ARG BASE_IMAGE=alpine:3.10
ARG NODEJS_VERSION=10.16.3-r0
ARG PYTHON_VERSION=3.7.5-r1

FROM ${BASE_IMAGE} AS downloader
ENV VALE_VERSION=1.7.1
WORKDIR /workarea
RUN apk add --no-cache \
        curl \
    && mkdir -p /downloader/bin \
    && curl -L -o /tmp/vale.tar.gz https://github.com/errata-ai/vale/releases/download/v${VALE_VERSION}/vale_${VALE_VERSION}_Linux_64-bit.tar.gz && tar xzvf /tmp/vale.tar.gz && cp vale /downloader/bin

FROM ${BASE_IMAGE} AS nodejs
ARG NODEJS_VERSION
RUN apk add --no-cache \
        nodejs=${NODEJS_VERSION} \
        nodejs-npm=${NODEJS_VERSION}
RUN npm install --global --no-cache --prefix /nodejs \
        markdownlint-cli@0.18 \
        textlint@11.3 \
        textlint-filter-rule-comments@1.2 \
        textlint-plugin-rst@0.1 \
        textlint-rule-alex@1.3 \
        textlint-rule-common-misspellings@1.0 \
        textlint-rule-no-dead-link@4.4 \
        textlint-rule-no-exclamation-question-mark@1.0 \
        @textlint-rule/textlint-rule-no-invalid-control-character@1.2 \
        textlint-rule-no-start-duplicated-conjunction@2.0 \
        textlint-rule-no-todo@2.0 \
        textlint-rule-sentence-length@2.1 \
        textlint-rule-terminology@1.1 \
        textlint-rule-write-good@1.6

FROM ${BASE_IMAGE} AS python
ARG PYTHON_VERSION
RUN apk add --no-cache \
        python3=${PYTHON_VERSION}
RUN python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --no-cache --upgrade pip setuptools wheel \
    && pip3 install --no-cache --install-option="--prefix=/python" \
        docutils \
        docutils-ast-writer \
        proselint \
        restructuredtext_lint \
    && ln -s /python/bin/rst2html.py /python/bin/rst2html

FROM ${BASE_IMAGE}
ARG NODEJS_VERSION
ARG PYTHON_VERSION
RUN apk add --no-cache \
        libc6-compat \
        nodejs=${NODEJS_VERSION} \
        python3=${PYTHON_VERSION} \
    && ln -s /usr/bin/python3 /usr/bin/python
COPY --from=downloader /downloader /downloader
COPY --from=nodejs /nodejs /nodejs
COPY --from=python /python /python
ENV PATH="${PATH}:/downloader/bin:/nodejs/bin:/python/bin"
ENV PYTHONPATH=/python/lib/python3.7/site-packages
