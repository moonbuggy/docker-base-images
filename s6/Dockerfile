# syntax = docker/dockerfile:1.4.0

ARG FROM_IMAGE="moonbuggy2000/fetcher:latest"

ARG S6_OVERLAY_VERSION="v3.1.1.2"
ARG TARGET_ARCH_TAG="amd64"
ARG SCRATCH_ARCH_TAG="${TARGET_ARCH_TAG}"

ARG S6_URL="https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}"

FROM "moonbuggy2000/fetcher:latest" AS fetcher

## get s6-overlay noarch files
#
FROM fetcher AS s6-noarch

ARG S6_URL
WORKDIR /s6/
RUN wget --no-check-certificate -O- "${S6_URL}/s6-overlay-noarch.tar.xz" | tar xJf -
RUN wget --no-check-certificate -O- "${S6_URL}/s6-overlay-symlinks-noarch.tar.xz" | tar xJf -
RUN wget --no-check-certificate -O- "${S6_URL}/s6-overlay-symlinks-arch.tar.xz" | tar xJf -

## get s6 overlay binaries
#
FROM fetcher AS s6-arch

ARG S6_URL
ARG S6_ARCH="amd64"
WORKDIR /s6/
RUN wget --no-check-certificate -qO- "${S6_URL}/s6-overlay-${S6_ARCH}.tar.xz" | tar xJf -


## build final image
#
FROM "moonbuggy2000/scratch:${SCRATCH_ARCH_TAG}"

COPY --from=s6-arch /s6/ /
COPY --from=s6-noarch /s6/ /
