# [Textlint](https://textlint.github.io/)

> The pluggable natural language linter for text and markdown.

Textlint allows to enable features via filters and rules.

Enable filters and rules using the Textlint configuration.
See sample [`.textlintrc`](./.textlintrc) and linked filter / rule configuration for an examples.

## Included Textlint filters

The Docker image contains these Textlint filters.

### [Comments](https://www.npmjs.com/package/textlint-filter-rule-comments)

> textlint rule that ignore error using comments directive

[Configuration for `comments`](https://www.npmjs.com/package/textlint-filter-rule-comments#settings).

## Included Textlint rules

The Docker image contains these Textlint rules.

### [ALEX](https://www.npmjs.com/package/textlint-rule-alex)

> textlint rule for [ALEX](https://alexjs.com/). Catch insensitive, inconsiderate writing.

[Configuration for `alex`](https://www.npmjs.com/package/textlint-rule-alex#options).

### [Common Misspellings](https://www.npmjs.com/package/textlint-rule-common-misspellings)

> textlint rule to find common misspellings from [Wikipedia: Lists of common misspellings](https://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_machines).

[Configuration for `common-misspellings`](https://www.npmjs.com/package/textlint-rule-common-misspellings#configuration).

### [No Dead Link](https://www.npmjs.com/package/textlint-rule-no-dead-link)

> textlint rule to make sure every link in a document is available.

[Configuration for `no-dead-link`](https://www.npmjs.com/package/textlint-rule-no-dead-link#options).

### [No Exclamation Question Mark](https://www.npmjs.com/package/textlint-rule-no-exclamation-question-mark)

> textlint rule that disallow exclamation and question mark.

[Configuration for `no-exclamation-question-mark`](https://www.npmjs.com/package/textlint-rule-no-exclamation-question-mark#options).

### [No Invalid Control Character](https://www.npmjs.com/package/@textlint-rule/textlint-rule-no-invalid-control-character)

> textlint rule check invalid control character in the document.

[Configuration for `@textlint-rule/no-invalid-control-character`](https://www.npmjs.com/package/@textlint-rule/textlint-rule-no-invalid-control-character#options).

### [No Start Duplicated Conjunction](https://www.npmjs.com/package/textlint-rule-no-start-duplicated-conjunction)

> textlint rule that check no start with duplicated conjunction.

[Configuration for `no-start-duplicated-conjunction`](https://www.npmjs.com/package/textlint-rule-no-start-duplicated-conjunction#config).

### [No Todo](https://www.npmjs.com/package/textlint-rule-no-todo)

> This textlint rule check todo mark.

[Configuration for `no-todo`](https://www.npmjs.com/package/textlint-rule-no-todo#usage).

See also the sample [`.textlintrc`](./.textlintrc) file.

### [Sentence Length](https://www.npmjs.com/package/textlint-rule-sentence-length)

> textlint rule that limit Maximum Length of Sentence.

[Configuration for `sentence-length`](https://www.npmjs.com/package/textlint-rule-sentence-length#options).

### [Terminology](https://www.npmjs.com/package/textlint-rule-terminology)

> Textlint rule to check and fix terms, brands and technologies spelling in your tech writing in English.

[Configuration for `terminology`](https://www.npmjs.com/package/textlint-rule-terminology#configuration).

### [Write Good](https://www.npmjs.com/package/textlint-rule-write-good)

> textlint rule to check your English writing styles with [btford/write-good](https://github.com/btford/write-good), naive linter for English prose

[Configuration for `write-good`](https://www.npmjs.com/package/textlint-rule-write-good#options).
