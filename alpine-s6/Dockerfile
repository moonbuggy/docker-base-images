ARG ALPINE_VERSION=3.11.2

FROM alpine:$ALPINE_VERSION

ARG S6_VERSION=v1.22.1.0
ARG S6_ARCH=amd64

ARG ALPINE_VERSION
ENV ALPINE_VERSION=${ALPINE_VERSION}

RUN apk add --no-cache --virtual .build curl \
	&& curl -L -s https://github.com/just-containers/s6-overlay/releases/download/$S6_VERSION/s6-overlay-$S6_ARCH.tar.gz | tar xvzf - -C / \
	&& apk del --no-cache .build

ENTRYPOINT ["/init"]
