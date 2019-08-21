# DocQA

DocQA is a QA *(Quality Assurance)* utility Docker image for your technical documentation.

## Usage

Intended usage is locally from the developer's workstation or
in the CI build of your projects.

### Quick usage

Run this Docker command:

```text
# example using markdownlint
$ docker run --init --tty --interactive --rm --user "$(id -u):$(id -g)"  --volume "/tmp:/.cache" --volume "$(pwd):/project" --workdir /project dkarlovi/docqa:latest markdownlint tests/bad-examples/markdownlint.md
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

See this repository's [`Makefile`](./../Makefile) for an example.

The idea is to have the tools tailored to the project's needs with custom configuration.

Developers run the same tools CI build runs (but locally), using the provided procedure, ie `make test`.

## Included tools

The included tools are:

- [Markdownlint](https://github.com/DavidAnson/markdownlint)
- [Proselint](https://github.com/amperser/proselint)
- [Redpen](https://github.com/redpen-cc/redpen)
- [Textlint](https://github.com/textlint/textlint)  
*(with plenty of plugins)*
