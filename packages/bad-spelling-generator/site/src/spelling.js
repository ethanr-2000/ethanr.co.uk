// Respells text in the browser using the data written by generator/src/generate.py:
// data/words/<first two letters>.json and data/syllables.json.

const files = new Map();

function load(path) {
  if (!files.has(path)) {
    const request = fetch(path).then((response) => {
      // No words file: no dictionary word starts with those two letters
      if (response.status === 404) {
        return {};
      }
      if (!response.ok) {
        throw new Error(`Failed to load ${path}: ${response.status}`);
      }
      return response.json();
    });
    // Forget failures, so the next lookup tries again
    request.catch(() => files.delete(path));
    files.set(path, request);
  }
  return files.get(path);
}

// Must match words_file() in generate.py
function wordsFile(word) {
  return Array.from(word).slice(0, 2).join("").replace(/[^a-z0-9]/g, "_");
}

// Only the file's own keys, so words like "__proto__" don't find Object's properties
function get(entries, key) {
  return Object.hasOwn(entries, key) ? entries[key] : undefined;
}

function pick(list) {
  return list[Math.floor(Math.random() * list.length)];
}

// A spelling and example word for each syllable, or null if the word can't be respelled
async function respell(word) {
  const key = word.toLowerCase();
  const [words, sounds] = await Promise.all([
    load(`./data/words/${wordsFile(key)}.json`),
    load("./data/syllables.json"),
  ]);
  const syllables = get(words, key);
  if (!syllables) {
    return null;
  }
  return syllables.map((sound) => {
    const [spelling, examples] = pick(get(sounds, sound));
    return { spelling, example: pick(examples) };
  });
}

// Splits text into words and the text between them, in order. Words also get
// `syllables`: what respell() returns for them.
export function spellBadText(text) {
  // With a capture group, split alternates: between, word, between, word, ...
  const pieces = text.split(/([\p{L}\p{N}_']+)/u);
  return Promise.all(pieces.map(async (piece, i) => (
    i % 2 === 1 ? { text: piece, syllables: await respell(piece) } : { text: piece }
  )));
}
