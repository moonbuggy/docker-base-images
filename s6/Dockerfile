# syntax = docker/dockerfile:1.4.0

ARG S6_OVERLAY_VERSION="v3.1.1.2"
ARG S6_URL="https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}"

ARG TARGET_ARCH_TAG="amd64"
ARG SCRATCH_ARCH_TAG="${TARGET_ARCH_TAG}"

## prepare base images
#
ARG BUILDPLATFORM="linux/amd64"
FROM --platform="${BUILDPLATFORM}" "moonbuggy2000/fetcher:latest" AS fetcher
WORKDIR /s6/

## get s6-overlay noarch
#
FROM fetcher AS s6-noarch
ARG S6_URL
RUN wget --no-check-certificate -qO- "${S6_URL}/s6-overlay-noarch.tar.xz" | tar xJf -
RUN wget --no-check-certificate -qO- "${S6_URL}/s6-overlay-symlinks-noarch.tar.xz" | tar xJf -
RUN wget --no-check-certificate -qO- "${S6_URL}/s6-overlay-symlinks-arch.tar.xz" | tar xJf -

## get s6 overlay binaries
#
FROM fetcher AS s6-arch
ARG S6_URL
ARG S6_ARCH="x86_64"
RUN wget --no-check-certificate -qO- "${S6_URL}/s6-overlay-${S6_ARCH}.tar.xz" | tar xJf -

## get add-contenv
#
FROM --platform="${BUILDPLATFORM}" moonbuggy2000/s6-add-contenv:s6-overlay-v3 AS add_contenv

## build final image
#
FROM "moonbuggy2000/scratch"

COPY --from=s6-arch /s6/ /
COPY --from=s6-noarch /s6/ /
COPY --from=add_contenv / /
