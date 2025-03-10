import re
import json

from helpers.spell_bad import spell_bad
from helpers.util import load_pronunciation_dictionary, load_isle

isleDict = load_isle()
pd = load_pronunciation_dictionary()

def handler(event, context):
  text = event['queryStringParameters']['text']

  words_list = re.findall(r"[\w']+|[.,!?; ]", text)
  response = {"words": []}
  for word in words_list:
      if re.match(r"[.,!?; ]", word):
          response['words'].append({'badlySpelled': [word]})
          continue
      bad_spell_response = spell_bad(word, isleDict, pd)
      response['words'].append(bad_spell_response)

  return {
    'isBase64Encoded': False,
    'statusCode': 200,
    'headers': {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': True,
      'Access-Control-Allow-Headers': '*'
    },
    'body': json.dumps(response)
  }
