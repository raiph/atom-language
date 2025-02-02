{
  'scopeName' => 'source.meta-info',
  'name' => 'META.info',
  'fileTypes' => [
    'META.info',
    'META6.json'
  ],
  'patterns' => [
    {
      'include' => '#value'
    },
  ],
  'repository' => {
    'array' => {
      'begin' => '\\[',
      'beginCaptures' => {
        '0' => {
          'name' => 'punctuation.definition.array.begin.json'
        }
      },
      'end' => '\\]',
      'endCaptures' => {
        '0' => {
          'name' => 'punctuation.definition.array.end.json'
        }
      },
      'name' => 'meta.structure.array.json',
      'patterns' => [
        {
          'include' => '#value'
        },
        {
          'match' => ',',
          'name' => 'punctuation.separator.array.json'
        },
        {
          'match' => Q/[^\s\]]/,
          'name' => 'invalid.illegal.expected-array-separator.json'
        }
      ]
    },
    'constant' => {
      'match' => '\\b(?:true|false|null)\\b',
      'name' => 'constant.language.json'
    },
    'number' => {
      'comment' => 'handles integer and decimal numbers',
      'match' => '-?(?=[1-9]|0(?!\\d))\\d+(\\.\\d+)?([eE][+-]?\\d+)?',
      'name' => 'constant.numeric.json'
    },
    'object' => {
      'begin' => '\\{',
      'beginCaptures' => {
        '0' => {
          'name' => 'punctuation.definition.dictionary.begin.json'
        }
      },
      'comment' => 'a JSON object',
      'end' => '\\}',
      'endCaptures' => {
        '0' => {
          'name' => 'punctuation.definition.dictionary.end.json'
        }
      },
      'name' => 'meta.structure.dictionary.json',
      'patterns' => [
        {
          'comment' => 'special META.info keys',
          'include' => '#fields'
        },
        {
          'comment' => 'the JSON object key',
          'include' => '#string'
        },
        {
          'begin' => ':',
          'beginCaptures' => {
            '0' => {
              'name' => 'punctuation.separator.dictionary.key-value.json'
            }
          },
          'end' => '(,)|(?=\\})',
          'endCaptures' => {
            '1' => {
              'name' => 'punctuation.separator.dictionary.pair.json'
            }
          },
          'name' => 'meta.structure.dictionary.value.json',
          'patterns' => [
            {
              'comment' => 'the JSON object value',
              'include' => '#value'
            },
            {
              'match' => '[^\\s,]',
              'name' => 'invalid.illegal.expected-dictionary-separator.json'
            }
          ]
        },
        {
          'match' => '[^\\s\\}]',
          'name' => 'invalid.illegal.expected-dictionary-separator.json'
        }
      ]
    },
    'fields' => {
      'match' => Q/(?x) "(?: perl|name|version|description|author(?:s)?|provides|depends|emulates| supersedes|superseded-by|excludes|build-depends|test-depends|resource| support|email|mailinglist|bugtracker|source|source-url|source-type| irc|phone|production|license|tags|auth )"/,
      'name' => 'entity.name.function.field.meta-info'
    },
    'string' => {
      'begin' => '"',
      'beginCaptures' => {
        '0' => {
          'name' => 'punctuation.definition.string.begin.json'
        }
      },
      'end' => '"',
      'endCaptures' => {
        '0' => {
          'name' => 'punctuation.definition.string.end.json'
        }
      },
      'name' => 'string.quoted.double.json',
      'patterns' => [
        {
          'match' => Q<(?x)\\(?:["\\/bfnrt]|u[0-9a-fA-F]{4})>,
          'name' => 'constant.character.escape.json'
        },
        {
          'match' => Q/\\./,
          'name' => 'invalid.illegal.unrecognized-string-escape.json'
        }
      ]
    },
    'value' => {
      'comment' => 'the \'value\' diagram at http://json.org',
      'patterns' => [
        {
          'include' => '#constant'
        },
        {
          'include' => '#number'
        },
        {
          'include' => '#string'
        },
        {
          'include' => '#array'
        },
        {
          'include' => '#object'
        }
      ]
    }
  }
}