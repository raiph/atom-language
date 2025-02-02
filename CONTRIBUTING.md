
Contributing
=================

* [Intro](#intro)
   * [Installing for Development](#installing-for-development)
   * [The issue tracker and you](#the-issue-tracker-and-you)
* [Making Changes to the Grammar and Helpful Tips:](#making-changes-to-the-grammar-and-helpful-tips)
   * [Oniguruma Regex Engine](#oniguruma-regex-engine)
* [TextMate Grammar Documentation](#textmate-grammar-documentation)
   * [Single line/simple matching](#single-linesimple-matching)
   * [Multi line matching](#multi-line-matching)
   * [Show me the source already!](#show-me-the-source-already)
   * [Testing](#testing)

## Intro
There are no good guides on writing TextMate grammars, so this is an attempt
to document some of the things I have learned — hopefully this will help
anybody wanting to contribute or work on this project.

I do this in the hope that I can ease the barrier of entry into development
on this project and share some of the things I have learned. Atom doesn't have
documentation on creating grammars, so I hope this to become a great resource
for others who may wish to contribute.

### Installing for Development (obsolete)
1. Clone the Github repository into any folder you wish.
2. Make sure the normal package is uninstalled.
3. Run `apm link atom-language-perl6`

This will install and link to the folder you just cloned. Now you are ready to
start hacking away!

### The issue tracker and you
For the purpose of this project, a *bug* is anything which alters the
highlighting of surrounding text. An *issue* is anything that highlighting
currently works on, but fails to work in some conditions.
Anything else is an *enhancement* .
Because of this, a priority system is the best way to categorize any issues.

* `priority:high` is reserved for bugs which ruin highlighting for a large
  number of lines below/around them. Often these will ruin highlighting for most
  if not all of the remaining document.
* `priority:medium` is for medium bugs that may alter a small amount of
  surrounding text. It is also for missing features/enhancements that are
  very important.
* `priority:low` is for either small bugs that don't ruin the highlighting of
  any surrounding text or reasonable enhancements.
* `priority:fun` is for enhancements that are not a priority, but would be nice
  to implement.

## Making Changes to the Grammar and Helpful Tips:

### Oniguruma Regex Engine
* The [Oniguruma][Oniguruma] regex engine is used by all programs which utilize
  TextMate style grammars (Sublime, Atom, TextMate).
* If you want use a hex codepoint instead of typing the symbol in, please use
  `\\x{20}` (Unescaped form: `\x{20}`).
  This will use the Regex engine for this instead of using the JSON method
  of noting unicode codepoints (e.g. `\u20` which can be used in JSON).
* Specify Unicode properties like this: `\\p{Alpha}`(`\p{Alpha}` in unescaped
  form). See the cheatsheet linked below for all the ones that are guaranteed
  to work.


* See the [Regex reference/cheatsheet][Oniguruma-RE] for Oniguruma.

* A helpful site to try out Ruby regex is [Rubular][Rubular], although it only
  assumes `/…/` regex syntax so you must escape forward slashes. You do not
  need to escape forward slashes in the JSON file.
* [Regex101](regex101.com) is more graphical and nicer but make
  sure to test out the regex on [Rubular][Rubular] once you have it assembled!

## TextMate Grammar Documentation
Reading the [documentation][textmate] for TextMate grammars is informative but
leaves some things unanswered. In this section I will go over the basics.

The JSON file at the top has the patterns which are matched, in order from top
to bottom.

### Single line/simple matching
The bottom of the file has named sections which can be 'included' into other
sections of the code with `'include': '#identifier_name'`.

The simplest for is ‘match’ which will only match at most against one line.

`'match': 'regex goes here'
'name': 'label.raku'`

When you specify a name for the match, this label gets applied to the entire
match of the regex. If you need to apply multiple labels, you should use
captures.

Captures can be listed to apply the labels to the numbered capture.

### Multi line matching
These are denoted with a begin and an end regex. You can use the captures
to apply style labels to the captures for the start and end.

Sometimes what you want is to highlight some section of text that starts and
ends at certain points. For that you can use subrules which will be applied
on top of the previous ones. You list the subrules in the Patterns section
of the rule you are working on.

### Show me the source already!
While the `grammars` folder contains the files to be used by editors, these files
are generated from the corresponding `.raku` files in the `dev` folder. Each `.raku`
file describes the content of the eventual `.json` files, the main advantages being:
- no need for custom templating; familiar concepts of code composition can be used
- Raku provides a great variety of string literals; superfluous escaping can be avoided
`dev/generate-grammars.raku` serves two purposes:
- it contains commonly used templates for quoting constructs, multi-line comments and q quoting
- it generates all `tmLanguage.json` files from the `tmLanguage.raku` files
To reiterate: `tmLanguage.json` files are generated - to edit the grammars, always make the
appropriate changes in the Raku files under `dev`.

### Testing (obsolete)
We all love tests, right? To run tests, run `apm test` and the tests will run.

The testing file is at `spec/grammar-raku-spec.js`. Please make sure
when adding a test, that you are able to make the test fail by altering the
values of the expected response. Syntax problems can cause tests to succeed
silently.

All lines must be 80 characters or under. Lines 81 or over will cause Travis CI
builds to fail.  Do NOT push the test file if there are any lines over 80
characters long.

Travis CI will also fail if it detects improper indenting (most of these will
error out when you run `apm test` yourself).



[Rubular]: http://rubular.com/
[Oniguruma]: https://en.wikipedia.org/wiki/Oniguruma
[Oniguruma-RE]: https://github.com/kkos/oniguruma/blob/master/doc/RE
[textmate]: https://manual.macromates.com/en/language_grammars.html
