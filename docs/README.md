# DocQA

The Docker image `dkarlovi/docqa` is a QA *(Quality Assurance)* utility for your technical documentation.

## Usage

Intended usage is locally from the developer's workstation or
in the CI build of your projects.

### Quick usage

Run this Docker command:

```text
# example using markdownlint
$ docker run --init --tty --interactive --rm --user "$(id -u):$(id -g)"  --volume "/tmp:/.cache" --volume "$(pwd):/project" --workdir /project dkarlovi/docqa:latest markdownlint tests/bad-examples/markdownlint.md
tests/bad-examples/markdownlint.md: 1: MD009/no-trailing-spaces Trailing spaces [Expected: 0 or 2; Actual: 1]
tests/bad-examples/markdownlint.md: 1: MD041/first-line-heading/first-line-h1 First line in file should be a top level heading [Context: "Trailing spaces "]
tests/bad-examples/markdownlint.md: 3: MD012/no-multiple-blanks Multiple consecutive blank lines [Expected: 1; Actual: 2]
```

To avoid having to keep type this long command, you can add it to your `~/.profile`:

```text
# in ~/.profile
alias docqa='docker run --init --tty --interactive --rm --user "$(id -u):$(id -g)"  --volume "/tmp:/.cache" --volume "$(pwd):/project" --workdir /project dkarlovi/docqa:latest'
```

Now the same command becomes much easier:

```text
$ docqa markdownlint tests/bad-examples/markdownlint.md
tests/bad-examples/markdownlint.md: 1: MD009/no-trailing-spaces Trailing spaces [Expected: 0 or 2; Actual: 1]
tests/bad-examples/markdownlint.md: 1: MD041/first-line-heading/first-line-h1 First line in file should be a top level heading [Context: "Trailing spaces "]
tests/bad-examples/markdownlint.md: 3: MD012/no-multiple-blanks Multiple consecutive blank lines [Expected: 1; Actual: 2]
```

### Use inside your projects

See this repository's [`Makefile`](./../Makefile) and sample [`config/`](../config) for an example.

The idea is to have the tools tailored to the project's needs with custom configuration.

Developers run the same tools CI build runs (but locally), using the provided procedure, i.e., `make test`.

## Included tools

The image contains these tools:

### [Markdownlint](https://github.com/DavidAnson/markdownlint)

> A Node.js style checker and lint tool for Markdown/CommonMark files.

[Configuration for `markdownlint`](https://github.com/DavidAnson/markdownlint/blob/master/doc/Rules.md).

### [Proselint](http://proselint.com/)

> A linter for prose.

[Configuration for `proselint`](https://github.com/amperser/proselint#checks).
  
### [RedPen](http://redpen.cc/)

> RedPen is an open source proofreading tool to check if your technical documents meet the writing standard. RedPen supports various markup text formats (Markdown, Textile, AsciiDoc, Re:VIEW, reStructuredText and LaTeX).

[Configuration for `redpen`](http://redpen.cc/docs/1.10/index.html#validator).

There is also the [RedPen online configuration generator](http://redpen.herokuapp.com/).

### [Textlint](https://textlint.github.io/)

> The pluggable natural language linter for text and markdown.

Textlint allows to enable features via filters and rules.

Enable filters and rules using the Textlint configuration.
See sample [`.textlintrc`](./../config/textlint/.textlintrc) and linked filter / rule configuration for an examples.

#### Included Textlint filters

The Docker image contains these Textlint filters.

##### [Comments](https://www.npmjs.com/package/textlint-filter-rule-comments)

> textlint rule that ignore error using comments directive

[Configuration for `comments`](https://www.npmjs.com/package/textlint-filter-rule-comments#settings).

#### Included Textlint rules

The Docker image contains these Textlint rules.

##### [ALEX](https://www.npmjs.com/package/textlint-rule-alex)

> textlint rule for [ALEX](https://alexjs.com/). Catch insensitive, inconsiderate writing.

[Configuration for `alex`](https://www.npmjs.com/package/textlint-rule-alex#options).

##### [Common Misspellings](https://www.npmjs.com/package/textlint-rule-common-misspellings)

> textlint rule to find common misspellings from [Wikipedia: Lists of common misspellings](https://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_machines).

[Configuration for `common-misspellings`](https://www.npmjs.com/package/textlint-rule-common-misspellings#configuration).

##### [No Dead Link](https://www.npmjs.com/package/textlint-rule-no-dead-link)

> textlint rule to make sure every link in a document is available.

[Configuration for `no-dead-link`](https://www.npmjs.com/package/textlint-rule-no-dead-link#options).

##### [No Exclamation Question Mark](https://www.npmjs.com/package/textlint-rule-no-exclamation-question-mark)

> textlint rule that disallow exclamation and question mark.

[Configuration for `no-exclamation-question-mark`](https://www.npmjs.com/package/textlint-rule-no-exclamation-question-mark#options).

##### [No Invalid Control Character](https://www.npmjs.com/package/@textlint-rule/textlint-rule-no-invalid-control-character)

> textlint rule check invalid control character in the document.

[Configuration for `@textlint-rule/no-invalid-control-character`](https://www.npmjs.com/package/@textlint-rule/textlint-rule-no-invalid-control-character#options).

##### [No Start Duplicated Conjunction](https://www.npmjs.com/package/textlint-rule-no-start-duplicated-conjunction)

> textlint rule that check no start with duplicated conjunction.

[Configuration for `no-start-duplicated-conjunction`](https://www.npmjs.com/package/textlint-rule-no-start-duplicated-conjunction#config).

##### [No Todo](https://www.npmjs.com/package/textlint-rule-no-todo)

> This textlint rule check todo mark.

[Configuration for `no-todo`](https://www.npmjs.com/package/textlint-rule-no-todo#usage).

See also the sample [`.textlintrc`](../config/textlint/.textlintrc) file.

##### [Sentence Length](https://www.npmjs.com/package/textlint-rule-sentence-length)

> textlint rule that limit Maximum Length of Sentence.

[Configuration for `sentence-length`](https://www.npmjs.com/package/textlint-rule-sentence-length#options).

##### [Terminology](https://www.npmjs.com/package/textlint-rule-terminology)

> Textlint rule to check and fix terms, brands and technologies spelling in your tech writing in English.

[Configuration for `terminology`](https://www.npmjs.com/package/textlint-rule-terminology#configuration).

##### [Write Good](https://www.npmjs.com/package/textlint-rule-write-good)

> textlint rule to check your English writing styles with [btford/write-good](https://github.com/btford/write-good), naive linter for English prose

[Configuration for `write-good`](https://www.npmjs.com/package/textlint-rule-write-good#options).

### [Vale](https://errata-ai.github.io/vale/)

> A syntax-aware linter for prose built with speed and extensibility in mind.

[Configuration for `vale`](https://errata-ai.github.io/vale/config/).
