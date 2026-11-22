"""Writes Bad Spelling Generator's data for the static site (site/src/data).

How each word can be respelled never changes, so it is worked out here once. A word
uses ISLE's first pronunciation, and can be respelled if every syllable sound has
spellings in src/data/pronunciation_dictionary (built by
dictionary-scripts/create_pronunciation_dictionary.py). The site fetches the words
file for the first two letters of each word typed, plus syllables.json, and picks
spellings at random.

From the generator directory:
    python3 -m venv .venv && .venv/bin/pip install -r requirements.txt
    .venv/bin/python src/generate.py
"""
import json
import pathlib
import random
import re
import shutil

from helpers.util import clean, load_isle, load_pronunciation_dictionary

OUT = pathlib.Path(__file__).resolve().parents[2] / "site" / "src" / "data"
MAX_EXAMPLES = 5  # Example words kept per spelling; the site shows one at a time

# The site splits input on this, so only words matching it are ever looked up
WORD = re.compile(r"^[\w']+$")


def words_file(word):
    """Name of the file a word is stored in. site/src/spelling.js must match this."""
    return re.sub(r"[^a-z0-9]", "_", word[:2])


def write_json(path, data):
    text = json.dumps(data, ensure_ascii=False, separators=(",", ":"), sort_keys=True)
    path.write_text(text, encoding="utf-8")


def main():
    isle = load_isle()
    pronunciations = load_pronunciation_dictionary()

    # word -> its syllable sounds, or 0 for a known word that can't be respelled
    words = {}
    for word in isle.data:
        if not WORD.match(word):
            continue
        # ISLE's first pronunciation. Entries with an internal word boundary come back
        # in parts (the Lambda used one part at random), so they're joined here
        phones = [syllable for part in isle.lookup(word) for syllable in part[0][0]]
        syllables = clean(["".join(syllable) for syllable in phones])
        words[word] = syllables if all(s in pronunciations for s in syllables) else 0

    # syllable sound -> [[spelling, [example words]], ...], for sounds that are used
    sounds = {}
    for sound in sorted({s for syllables in words.values() if syllables for s in syllables}):
        sounds[sound] = []
        for spelling, origins in sorted(pronunciations[sound].items()):
            examples = sorted({"".join(origin) for origin in origins})
            if len(examples) > MAX_EXAMPLES:
                # Seeded per spelling, so a change elsewhere doesn't reshuffle these
                rng = random.Random(f"{sound}/{spelling}")
                examples = sorted(rng.sample(examples, MAX_EXAMPLES))
            sounds[sound].append([spelling, examples])

    files = {}
    for word, syllables in words.items():
        files.setdefault(words_file(word), {})[word] = syllables

    shutil.rmtree(OUT, ignore_errors=True)
    (OUT / "words").mkdir(parents=True)
    for name, entries in files.items():
        write_json(OUT / "words" / f"{name}.json", entries)
    write_json(OUT / "syllables.json", sounds)

    respellable = sum(1 for syllables in words.values() if syllables)
    print(f"{len(words)} words ({respellable} respellable) in {len(files)} files, "
          f"{len(sounds)} syllable sounds -> {OUT}")


if __name__ == "__main__":
    main()
