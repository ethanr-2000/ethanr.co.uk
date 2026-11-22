// Respells text in the browser using the data written by generator/src/generate.py.
// Only the shards for the words typed (and their syllables) are fetched.

const WORD_SHARDS = 256;
const SYLLABLE_SHARDS = 64;
const PUNCTUATION = /^[.,!?; ]$/;

const shards = new Map();

// FNV-1a over code points: must match shard() in generate.py
function shardIndex(key, count) {
  let hash = 2166136261;
  for (const ch of key) {
    hash = Math.imul(hash ^ ch.codePointAt(0), 16777619) >>> 0;
  }
  return hash % count;
}

function lookup(kind, count, key) {
  const url = `./data/${kind}/${shardIndex(key, count)}.json`;
  if (!shards.has(url)) {
    shards.set(url, fetch(url).then((response) => {
      if (!response.ok) {
        shards.delete(url);
        throw new Error(`Failed to load ${url}: ${response.status}`);
      }
      return response.json();
    }));
  }
  return shards.get(url).then((entries) => entries[key]);
}

function pick(list) {
  return list[Math.floor(Math.random() * list.length)];
}

async function spellBadWord(word) {
  const result = { word, badlySpelled: [word], syllableOrigins: [] };

  // An array of syllable sounds, 0 for a known word that can't be respelled,
  // or undefined for a word that isn't in the dictionary
  const syllables = await lookup("words", WORD_SHARDS, word.toLowerCase());
  if (syllables === undefined) {
    result.syllableOrigins = null;
    return result;
  }
  if (syllables === 0) {
    return result;
  }

  const options = await Promise.all(syllables.map((s) => lookup("syllables", SYLLABLE_SHARDS, s)));
  result.badlySpelled = [];
  for (const spellings of options) {
    const [spelling, examples] = pick(spellings);
    result.badlySpelled.push(spelling);
    result.syllableOrigins.push({ word: [pick(examples)] });
  }
  return result;
}

// Same response shape the old /api returned
export async function spellBadText(text) {
  const tokens = text.match(/[\p{L}\p{N}_']+|[.,!?; ]/gu) ?? [];
  const words = await Promise.all(
    tokens.map((token) => (PUNCTUATION.test(token) ? { badlySpelled: [token] } : spellBadWord(token))),
  );
  return { words };
}
