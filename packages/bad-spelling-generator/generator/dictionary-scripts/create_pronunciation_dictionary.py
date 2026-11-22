import pathlib
import sys
sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent.parent / 'src'))
from helpers.tokenizer import tokenizer
from helpers.util import phone_to_syllable_list, load_english_words, load_isle, save_pronunciation_dictionary

words = load_english_words()
isleDict = load_isle()

pronunciations_dictionary = {}

for word in words:
    pronunciations = isleDict.data.get(word)
    if not pronunciations:
        continue

    # Every pronunciation, so the site finds spellings for whichever one it uses
    for pronunciation in pronunciations:
        pronunciations_list = phone_to_syllable_list(pronunciation[0])
        tokenized_word = tokenizer(word, pronunciations_list)

        if '' in tokenized_word:
            continue

        print(tokenized_word, pronunciations_list)

        for i, syl in enumerate(pronunciations_list):
            if pronunciations_dictionary.get(syl) is None:
                pronunciations_dictionary[syl] = {tokenized_word[i]: [tokenized_word]}
                continue
            pronunciations_dictionary[syl].setdefault(tokenized_word[i], []).append(tokenized_word)


save_pronunciation_dictionary(pronunciations_dictionary)
