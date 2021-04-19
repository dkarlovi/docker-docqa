ARG BASE_IMAGE=alpine:3.13
ARG NODEJS_VERSION=14.16.1-r1
ARG PYTHON_VERSION=3.8.8-r0

FROM ${BASE_IMAGE} AS downloader
ENV VALE_VERSION=2.10.2
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
        markdownlint-cli \
        textlint \
        textlint-filter-rule-comments \
        textlint-plugin-rst \
        textlint-rule-alex \
        textlint-rule-common-misspellings \
        textlint-rule-no-dead-link \
        textlint-rule-no-exclamation-question-mark \
        @textlint-rule/textlint-rule-no-invalid-control-character \
        textlint-rule-no-start-duplicated-conjunction \
        textlint-rule-no-todo \
        textlint-rule-sentence-length \
        textlint-rule-terminology \
        textlint-rule-write-good

FROM ${BASE_IMAGE} AS python
ARG PYTHON_VERSION
RUN apk add --no-cache \
        python3=${PYTHON_VERSION}
RUN python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --no-cache --upgrade pip setuptools wheel \
    && pip3 install --no-cache --prefix=/python \
        docutils \
        docutils-ast-writer \
        restructuredtext_lint \
    && ln -s /python/bin/rst2html.py /python/bin/rst2html

FROM ${BASE_IMAGE}
ARG NODEJS_VERSION
ARG PYTHON_VERSION
RUN apk add --no-cache \
        asciidoctor \
        libc6-compat \
        make \
        nodejs=${NODEJS_VERSION} \
        python3=${PYTHON_VERSION} \
    && ln -s /usr/bin/python3 /usr/bin/python
COPY --from=downloader /downloader /downloader
COPY --from=nodejs /nodejs /nodejs
COPY --from=python /python /python
ENV PATH="${PATH}:/downloader/bin:/nodejs/bin:/python/bin"
ENV PYTHONPATH=/python/lib/python3.8/site-packages
