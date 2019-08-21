DOCQA_DOCKER_IMAGE_NAME=dkarlovi/docqa
DOCQA_DOCKER_IMAGE_TAG=latest
DOCQA_DOCKER_IMAGE=${DOCQA_DOCKER_IMAGE_NAME}:${DOCQA_DOCKER_IMAGE_TAG}
DOCQA_DOCKER_COMMAND=docker run --init --interactive --rm --env XDG_CONFIG_HOME=/project --user "$(shell id -u):$(shell id -g)"  --volume "$(shell pwd)/var/tmp/docqa:/.cache" --volume "$(shell pwd):/project" --workdir /project ${DOCQA_DOCKER_IMAGE}

build: clean
	docker build . -t ${DOCQA_DOCKER_IMAGE}

test: markdownlint proselint textlint redpen

push: build
	docker push ${DOCQA_DOCKER_IMAGE}

markdownlint: ensure
	sh -c "${DOCQA_DOCKER_COMMAND} markdownlint --config markdownlint.yaml.dist README.md docs/*.md"

proselint: ensure
	sh -c "${DOCQA_DOCKER_COMMAND} proselint README.md docs/*.md"

textlint: ensure
	sh -c "${DOCQA_DOCKER_COMMAND} textlint --config .textlintrc.dist README.md docs/*.md"

redpen: ensure
	sh -c "${DOCQA_DOCKER_COMMAND} redpen --conf redpen.xml.dist --threshold info --result-format plain2 README.md docs/*.md"

ensure:
	mkdir -p var/tmp/docqa

clean:
	rm -rf var/

