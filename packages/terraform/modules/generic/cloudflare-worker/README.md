# cloudflare-worker

A Cloudflare Worker on a custom domain, serving static files, a script, or both.

Defaults:

- Served only on `hostname`: the `*.workers.dev` URL and preview URLs are off.
- The custom domain creates its own DNS record and certificate.
- Workers Logs are on.
- An assets-only Worker serves `index.html` for paths that match no file, so client-side routes work.
- Static files are served before the script runs, so a script only sees requests that match no file.

## Static site

```hcl
module "my_site" {
  source = "../../modules/generic/cloudflare-worker"

  account_id       = var.cloudflare_account_id
  zone_id          = var.cloudflare_zone_id
  hostname         = "my-site.${var.fqdn}"
  assets_directory = "${local.build_root}/my-site"

  unique_ids = {
    local = "${local.unique_id}-my-site"
  }
}
```

## Script, with static files and bindings

The script is a single ES module file exporting a `fetch` handler. It reads static files through `env.ASSETS` and bindings through `env.<NAME>`.

```hcl
module "my_api" {
  source = "../../modules/generic/cloudflare-worker"

  account_id       = var.cloudflare_account_id
  zone_id          = var.cloudflare_zone_id
  hostname         = "my-api.${var.fqdn}"
  script_path      = "${path.module}/worker/index.js"
  assets_directory = "${local.build_root}/my-api-site"

  plain_text_bindings = {
    UPSTREAM_URL = "https://example.com"
  }

  secret_bindings = {
    API_KEY = random_password.api_key.result
  }

  unique_ids = {
    local = "${local.unique_id}-my-api"
  }
}
```

The Cloudflare API token needs Account → Workers Scripts → Edit and, for `hostname`, Zone → Workers Routes → Edit. The hostname must not already have its own A, AAAA or CNAME record.

## Inputs

| Name | Default | Description |
|------|---------|-------------|
| `unique_ids.local` | | The Worker's name |
| `account_id` | | Cloudflare account ID |
| `zone_id` | `null` | Zone for `hostname`; worked out from the hostname if null |
| `hostname` | `null` | Custom domain; null for none |
| `assets_directory` | `null` | Static files to upload |
| `not_found_handling` | `single-page-application` | Assets-only Workers: `single-page-application`, `404-page` or `none` |
| `script_path` | `null` | Single-file ES module script |
| `assets_binding_name` | `ASSETS` | Name of the static files binding when there is a script |
| `plain_text_bindings` | `{}` | `env.<NAME>` plain text values |
| `secret_bindings` | `{}` | `env.<NAME>` secret values |
| `compatibility_date` | `2026-11-01` | Workers runtime compatibility date |
| `logs_enabled` | `true` | Workers Logs |

## Outputs

| Name | Description |
|------|-------------|
| `script_name` | The Worker's name |
| `url` | `https://<hostname>`, or null |
