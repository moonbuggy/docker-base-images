ARG DEB_RELEASE="buster"
ARG SOURCE_IMAGE="debian:${DEB_RELEASE}-slim"

## get s6 overlay
#
FROM moonbuggy2000/fetcher:latest AS fetcher

ARG S6_VERSION=v2.2.0.1
ARG S6_ARCH=amd64

RUN mkdir /s6/ \
	&& wget --no-check-certificate -qO- https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.gz | tar xzf - -C /s6/

## build the image
#
FROM ${SOURCE_IMAGE}

COPY ./root /
COPY --from=fetcher /s6/ /

ARG DEB_RELEASE

RUN add-contenv DEB_RELEASE=${DEB_RELEASE}

ENTRYPOINT ["/init"]