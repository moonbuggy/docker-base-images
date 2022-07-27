# syntax = docker/dockerfile:1.4.0

ARG NODE_VERSION="18"
ARG ALPINE_VERSION="3.16"

ARG FROM_IMAGE="node:${NODE_VERSION}-alpine${ALPINE_VERSION}"

ARG BUILDPLATFORM="linux/amd64"
FROM --platform="${BUILDPLATFORM}" moonbuggy2000/s6-add-contenv:s6-overlay-v3 AS add_contenv

## prepare config files
#
FROM "${FROM_IMAGE}" AS config

COPY root/ /config_root/
COPY --from=add_contenv / /config_root/

WORKDIR /config_root/etc/

# determine the s6 overlay major version in use, remove any uneeded config
#   v2.* uses /etc/s6,  v3.* uses /etc/s6-overlay
ARG S6_VERSION="3"
RUN case "${S6_VERSION%%.*}" in \
    "2") rm -rvf s6-overlay 2>/dev/null ;; \
    *) rm -rvf cont-init.d services.d fix-attrs.d 2>/dev/null ;; \
  esac

# configure environment
ARG NODE_VERSION
RUN echo "NODE_VERSION=${NODE_VERSION}" >> contenv_extra

## build the image
#
FROM "${FROM_IMAGE}"

# enable use of TZ enviornment variable and install s6-overlay
RUN apk -U add --no-cache \
    s6-overlay \
    tzdata

COPY --from=config /config_root/ /

ENTRYPOINT ["/init"]
