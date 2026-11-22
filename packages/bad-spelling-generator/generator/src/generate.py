"""Writes Bad Spelling Generator's data for the static site (site/src/data).

For each word, whether and how it can be respelled never changes: it uses ISLE's
first pronunciation, and only if the tokenizer can split the word into one chunk
per syllable and every syllable has known spellings. That is worked out here once.
The site only fetches the shards for the words typed and picks spellings at random.

Run from this directory: pipenv run python src/generate.py
"""
import json
import pathlib
import random
import re
import shutil

from helpers.tokenizer import tokenizer
from helpers.util import clean, load_isle, load_pronunciation_dictionary

OUT = pathlib.Path(__file__).resolve().parents[2] / "site" / "src" / "data"
WORD_SHARDS = 256
SYLLABLE_SHARDS = 64
MAX_ORIGINS = 5  # Example words kept per spelling; the site shows one at a time

# The site splits input on this, so only words matching it are ever looked up
WORD = re.compile(r"^[\w']+$")


def shard(key, count):
    """FNV-1a over code points. site/src/spelling.js must use the same function."""
    h = 2166136261
    for ch in key:
        h = ((h ^ ord(ch)) * 16777619) & 0xFFFFFFFF
    return h % count


def write_shards(name, entries, count):
    shards = [{} for _ in range(count)]
    for key, value in entries.items():
        shards[shard(key, count)][key] = value
    (OUT / name).mkdir(parents=True)
    for i, entries in enumerate(shards):
        path = OUT / name / f"{i}.json"
        path.write_text(json.dumps(entries, ensure_ascii=False, separators=(",", ":"), sort_keys=True))


def main():
    isle = load_isle()
    pronunciations = load_pronunciation_dictionary()

    # word -> its syllable sounds, or 0 for a known word that can't be respelled
    words = {}
    for word in isle.data:
        if not WORD.match(word):
            continue
        # ISLE's first pronunciation, as before. Entries with an internal word boundary
        # come back in parts; the Lambda used one part at random, so they're joined here
        phones = [syllable for part in isle.lookup(word) for syllable in part[0][0]]
        syllables = clean(["".join(syllable) for syllable in phones])
        respellable = len(syllables) == len(tokenizer(word, syllables)) and all(
            s in pronunciations for s in syllables
        )
        words[word] = syllables if respellable else 0

    # syllable sound -> [[spelling, [example words]], ...], for sounds that are used
    rng = random.Random(0)
    sounds = {}
    for sound in sorted({s for syllables in words.values() if syllables for s in syllables}):
        sounds[sound] = []
        for spelling, origins in sorted(pronunciations[sound].items()):
            examples = sorted({"".join(origin) for origin in origins})
            if len(examples) > MAX_ORIGINS:
                examples = sorted(rng.sample(examples, MAX_ORIGINS))
            sounds[sound].append([spelling, examples])

    shutil.rmtree(OUT, ignore_errors=True)
    write_shards("words", words, WORD_SHARDS)
    write_shards("syllables", sounds, SYLLABLE_SHARDS)

    respellable = sum(1 for v in words.values() if v)
    print(f"{len(words)} words ({respellable} respellable), {len(sounds)} syllable sounds -> {OUT}")


if __name__ == "__main__":
    main()
