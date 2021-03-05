ARG PYPY_VERSION="3.7"
ARG DEBIAN_RELEASE="buster"
ARG FROM_IMAGE="pypy:${PYPY_VERSION}-${DEBIAN_RELEASE}-slim"

## get s6 overlay
#
FROM moonbuggy2000/fetcher:latest AS fetcher

ARG S6_VERSION="v2.2.0.3"
ARG S6_ARCH="amd64"

RUN mkdir /s6/ \
	&& wget --no-check-certificate -qO- https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.gz | tar xzf - -C /s6/

## build the image
#
FROM ${FROM_IMAGE}

COPY --from=fetcher /s6/ /
COPY ./root /

ARG DEBIAN_RELEASE
ARG PYPY_VERSION

RUN add-contenv DEB_RELEASE="${DEBIAN_RELEASE}" PYPY_VERSION="${PYPY_VERSION}"

ENTRYPOINT ["/init"]
