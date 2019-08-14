ARG BASE_IMAGE=alpine:3.10
ARG NODEJS_VERSION=10.16.0-r0
ARG PYTHON_VERSION=3.7.3-r0
ARG OPENJDK_VERSION=8.212.04-r1

FROM ${BASE_IMAGE} AS nodejs
ARG NODEJS_VERSION
RUN apk add --no-cache \
        nodejs=${NODEJS_VERSION} \
        nodejs-npm=${NODEJS_VERSION}
RUN npm install --global --no-cache --prefix /nodejs \
        markdownlint-cli@0.17.0 \
        textlint@11.3 \
        textlint-rule-alex@1.3.1 \
        textlint-rule-no-exclamation-question-mark@1.0.2 \
        textlint-rule-no-todo@2.0.0

FROM ${BASE_IMAGE} AS python
ARG PYTHON_VERSION
RUN apk add --no-cache \
        python3=${PYTHON_VERSION}
RUN python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --no-cache --upgrade pip setuptools wheel \
    && pip3 install --no-cache --install-option="--prefix=/python" \
        proselint

FROM ${BASE_IMAGE} AS redpen
WORKDIR /build
ARG OPENJDK_VERSION
RUN apk add --no-cache \
        git \
        maven \
        openjdk8=${OPENJDK_VERSION} \
    && git clone https://github.com/redpen-cc/redpen.git --depth=1
WORKDIR /build/redpen
RUN mvn install

FROM ${BASE_IMAGE}
ARG NODEJS_VERSION
ARG OPENJDK_VERSION
ARG PYTHON_VERSION
RUN apk add --no-cache \
        nodejs=${NODEJS_VERSION} \
        openjdk8-jre-base=${OPENJDK_VERSION} \
        python3=${PYTHON_VERSION}
COPY --from=nodejs /nodejs /nodejs
COPY --from=redpen /build/redpen/redpen-cli/target/redpen-cli-1.10.3-SNAPSHOT-assembled/redpen-cli-1.10.3-SNAPSHOT /redpen
COPY --from=python /python /python
ENV PATH="${PATH}:/nodejs/bin:/python/bin:/redpen/bin"
ENV PYTHONPATH=/python/lib/python3.7/site-packages
