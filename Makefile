DOCQA_DOCKER_IMAGE_NAME=dkarlovi/docqa
DOCQA_DOCKER_IMAGE_TAG=latest
DOCQA_DOCKER_IMAGE=${DOCQA_DOCKER_IMAGE_NAME}:${DOCQA_DOCKER_IMAGE_TAG}
DOCQA_DOCKER_COMMAND=docker run --init --interactive --rm --env XDG_CONFIG_HOME=/project/config --user "$(shell id -u):$(shell id -g)"  --volume "$(shell pwd)/var/tmp/docqa:/.cache" --volume "$(shell pwd):/project" --workdir /project ${DOCQA_DOCKER_IMAGE}

DOCS_PATHS=README.md config/*/*.md docs/*.md tests/good-examples/hello.rst

build: clean
	docker build . -t ${DOCQA_DOCKER_IMAGE}

test: markdownlint rstlint proselint textlint vale

push: build
	docker push ${DOCQA_DOCKER_IMAGE}

markdownlint: ensure
	sh -c "${DOCQA_DOCKER_COMMAND} markdownlint --config config/markdownlint/markdownlint.yaml ${DOCS_PATHS}"

rstlint: ensure
	sh -c "${DOCQA_DOCKER_COMMAND} rst-lint --level info tests/good-examples/hello.rst"

# proselint is using $XDG_CONFIG_HOME/proselint/config as the config file
proselint: ensure
	sh -c "${DOCQA_DOCKER_COMMAND} proselint ${DOCS_PATHS}"

textlint: ensure
	sh -c "${DOCQA_DOCKER_COMMAND} textlint --config config/textlint/.textlintrc ${DOCS_PATHS}"

vale: ensure
	sh -c "${DOCQA_DOCKER_COMMAND} vale --config config/vale/.vale.ini ${DOCS_PATHS}"

ensure:
	mkdir -p var/tmp/docqa

clean:
	rm -rf var/

