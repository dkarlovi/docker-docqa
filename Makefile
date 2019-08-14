build:
	docker build . -t dkarlovi/docqa:latest

push: build
	docker push dkarlovi/docqa:latest
