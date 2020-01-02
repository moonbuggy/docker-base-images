ARG PYPY_PYTHON_VERSION=3.6
ARG ALPINE_VERSION=3.11

FROM jamiehewland/alpine-pypy:${PYPY_PYTHON_VERSION}-alpine${ALPINE_VERSION}

ARG S6_VERSION=v1.22.1.0
ARG S6_ARCH=amd64

ARG ALPINE_VERSION
ENV ALPINE_VERSION=${ALPINE_VERSION}

RUN apk add --no-cache curl \
	&& curl -L -s https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.gz | tar xvzf - -C / \
	&& apk del --no-cache curl

ENTRYPOINT ["/init"]

