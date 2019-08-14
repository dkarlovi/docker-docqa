ARG BASE_IMAGE=alpine:3.10

FROM ${BASE_IMAGE}
ARG NODE_VERSION=10.16.0-r0
ARG PYTHON_VERSION=3.7.3-r0
RUN apk add --no-cache \
        nodejs=${NODE_VERSION} \
        nodejs-npm=${NODE_VERSION} \
        python3=${PYTHON_VERSION} \
    && npm install -g --no-cache \
        markdownlint-cli@0.17.0 \
        textlint@11.3 \
        textlint-rule-alex@1.3.1 \
        textlint-rule-no-exclamation-question-mark@1.0.2 \
        textlint-rule-no-todo@2.0.0 \
    && python3 -m ensurepip && rm -r /usr/lib/python*/ensurepip && pip3 install --no-cache --upgrade pip setuptools wheel \
    && pip3 install --no-cache-dir \
        proselint
