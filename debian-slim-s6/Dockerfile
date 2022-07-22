# syntax = docker/dockerfile:1.4.0

ARG DEBIAN_RELEASE="bullseye"
ARG DEBIAN_VERISON="11.4"
ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

ARG FROM_IMAGE="debian:${DEBIAN_VERSION}-slim"

## get s6 overlay
#
FROM "moonbuggy2000/s6:${S6_VERSION}-${S6_ARCH}" AS s6

## prepare config files
#
FROM "${FROM_IMAGE}" AS config

COPY --from=s6 / /config_root/
COPY root/ /config_root/

WORKDIR /config_root/etc/

# determine the s6 overlay major version in use, remove any uneeded config
#   v2.* uses /etc/s6,  v3.* uses /etc/s6-overlay
RUN if [ -d "s6" ]; then \
    echo "*** Removing s6-overlay V3 init scripts.."; \
    rm -rvf s6-overlay 2>/dev/null; \
  elif [ -d "s6-overlay" ]; then \
    echo "*** Removing s6-overlay V2 init scripts.."; \
    rm -rvf cont-init.d services.d fix-attrs.d 2>/dev/null; \
  fi

# configure environment
ARG DEBIAN_RELEASE
ARG DEBIAN_VERSION
RUN echo "DEB_RELEASE=$(echo ${DEBIAN_RELEASE})" >> contenv_extra \
  && echo "DEB_VERSION=$(echo ${DEBIAN_VERSION})" >> contenv_extra


## build the image
#
FROM "${FROM_IMAGE}"

COPY --from=config /config_root/ /

ENTRYPOINT ["/init"]
