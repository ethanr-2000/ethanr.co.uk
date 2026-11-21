// Static files are served before this script runs, so it only sees /api and paths that
// match no file. /api is forwarded to the Lambda function URL, signed with SigV4.

const API_CACHE_SECONDS = 60 * 60 * 24 * 30; // Same as the old CloudFront cache policy

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);

    if (url.pathname === "/api") {
      return handleApi(request, url, env, ctx);
    }

    // Like the old CloudFront error responses: unknown paths get the site's index page
    return env.ASSETS.fetch(new Request(new URL("/", url), request));
  },
};

async function handleApi(request, url, env, ctx) {
  if (request.method !== "GET") {
    return new Response("Method not allowed", { status: 405 });
  }

  // Only `text` affects the response, so it is the only parameter forwarded or cached on
  const text = url.searchParams.get("text") ?? "";
  const cacheKey = new Request(`${url.origin}/api?text=${encodeURIComponent(text)}`);

  const cached = await caches.default.match(cacheKey);
  if (cached) {
    return cached;
  }

  // Sent in the same encoding it is signed in (spaces as %20, not +)
  const lambdaUrl = new URL(env.LAMBDA_URL);
  lambdaUrl.search = `text=${uriEncode(text)}`;

  const upstream = await fetch(lambdaUrl, {
    headers: await signRequest(lambdaUrl, env, new Date()),
  });

  const response = new Response(upstream.body, upstream);
  if (upstream.ok) {
    response.headers.set("Cache-Control", `public, max-age=${API_CACHE_SECONDS}`);
    ctx.waitUntil(caches.default.put(cacheKey, response.clone()));
  }
  return response;
}

// SigV4 headers for an unsigned-payload GET to a Lambda function URL
async function signRequest(url, env, now) {
  const service = "lambda";
  const amzDate = now.toISOString().replace(/[:-]|\.\d{3}/g, "");
  const date = amzDate.slice(0, 8);
  const scope = `${date}/${env.AWS_REGION}/${service}/aws4_request`;

  const canonicalQuery = [...url.searchParams]
    .map(([key, value]) => [uriEncode(key), uriEncode(value)])
    .sort(([a, x], [b, y]) => (a === b ? compare(x, y) : compare(a, b)))
    .map(([key, value]) => `${key}=${value}`)
    .join("&");

  const canonicalRequest = [
    "GET",
    url.pathname || "/",
    canonicalQuery,
    `host:${url.host}\nx-amz-date:${amzDate}\n`,
    "host;x-amz-date",
    await sha256Hex(""),
  ].join("\n");

  const stringToSign = ["AWS4-HMAC-SHA256", amzDate, scope, await sha256Hex(canonicalRequest)].join("\n");

  let key = new TextEncoder().encode(`AWS4${env.AWS_SECRET_ACCESS_KEY}`);
  for (const part of [date, env.AWS_REGION, service, "aws4_request"]) {
    key = await hmac(key, part);
  }
  const signature = toHex(await hmac(key, stringToSign));

  return {
    "x-amz-date": amzDate,
    authorization: `AWS4-HMAC-SHA256 Credential=${env.AWS_ACCESS_KEY_ID}/${scope}, SignedHeaders=host;x-amz-date, Signature=${signature}`,
  };
}

// RFC 3986 encoding, which encodeURIComponent falls short of for !'()*
function uriEncode(value) {
  return encodeURIComponent(value).replace(/[!'()*]/g, (c) => `%${c.charCodeAt(0).toString(16).toUpperCase()}`);
}

function compare(a, b) {
  return a < b ? -1 : a > b ? 1 : 0;
}

async function sha256Hex(message) {
  return toHex(await crypto.subtle.digest("SHA-256", new TextEncoder().encode(message)));
}

async function hmac(key, message) {
  const cryptoKey = await crypto.subtle.importKey("raw", key, { name: "HMAC", hash: "SHA-256" }, false, ["sign"]);
  return new Uint8Array(await crypto.subtle.sign("HMAC", cryptoKey, new TextEncoder().encode(message)));
}

function toHex(buffer) {
  return [...new Uint8Array(buffer)].map((b) => b.toString(16).padStart(2, "0")).join("");
}
