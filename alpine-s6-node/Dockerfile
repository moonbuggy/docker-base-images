# syntax = docker/dockerfile:1.4.0

ARG NODE_VERSION="18"
ARG ALPINE_VERSION="3.16"

ARG FROM_IMAGE="node:${NODE_VERSION}-alpine${ALPINE_VERSION}"
ARG BUILDPLATFORM="linux/amd64"

## get s6-add-contenv
#
FROM --platform="${BUILDPLATFORM}" moonbuggy2000/s6-add-contenv:s6-overlay-v3 AS add-contenv

## prepare config files
#
FROM --platform="${BUILDPLATFORM}" "${FROM_IMAGE}" AS config

COPY root/ /config_root/
COPY --from=add-contenv / /config_root/

WORKDIR /config_root/etc/
ARG NODE_VERSION
RUN echo "NODE_VERSION=${NODE_VERSION}" >> contenv_extra

## build the image
#
FROM "${FROM_IMAGE}"

# install s6-overlay and enable use of TZ enviornment variable
RUN apk -U add --no-cache \
    s6-overlay \
    tzdata

COPY --from=config /config_root/ /

ENTRYPOINT ["/init"]
