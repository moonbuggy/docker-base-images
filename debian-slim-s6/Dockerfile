ARG SOURCE_TAG="buster-slim"
ARG FROM_IMAGE="debian:${SOURCE_TAG}"

## get s6 overlay
#
FROM moonbuggy2000/fetcher:latest AS fetcher

ARG S6_VERSION=v2.2.0.1
ARG S6_ARCH=amd64

RUN mkdir /s6/ \
	&& wget --no-check-certificate -qO- https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.gz | tar xzf - -C /s6/

## build the image
#
FROM ${FROM_IMAGE}

COPY ./root /
COPY --from=fetcher /s6/ /

ARG TARGET_TAG

RUN add-contenv DEB_RELEASE=${TARGET_TAG}

ENTRYPOINT ["/init"]
