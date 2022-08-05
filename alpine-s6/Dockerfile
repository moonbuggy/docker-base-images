# syntax = docker/dockerfile:1.4.0

ARG ALPINE_VERSION="3.16.1"
ARG S6_VERSION="3.1.0.1"

ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"
ARG BUILDPLATFORM="linux/amd64"

## get s6-add-contenv
#
FROM --platform="${BUILDPLATFORM}" moonbuggy2000/s6-add-contenv:s6-overlay-v3 AS add_contenv

## prepare config files
#
FROM --platform="${BUILDPLATFORM}" "${FROM_IMAGE}" AS config

COPY --from=add_contenv / /config_root/
COPY root/ /config_root/

WORKDIR /config_root/etc/
ARG ALPINE_VERSION
RUN echo "ALPINE_VERSION=${ALPINE_VERSION}" >> contenv_extra

## build the image
#
FROM "${FROM_IMAGE}"

# install s6-overlay and enable use of TZ enviornment variable
RUN apk -U add --no-cache \
    s6-overlay \
    tzdata

COPY --from=config /config_root/ /

ENTRYPOINT ["/init"]
