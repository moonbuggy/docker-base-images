# syntax=docker/dockerfile:1.3-labs

ARG DEBIAN_RELEASE="buster"
ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

ARG FROM_IMAGE="debian:${DEBIAN_RELEASE}-slim"

ARG TARGET_ARCH_TAG="amd64"

## get s6 overlay
#
FROM "moonbuggy2000/s6:${S6_VERSION}-${S6_ARCH}" AS s6

## prepare files
#
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR
ARG QEMU_ARCH
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

COPY --from=s6 / /
COPY ./root/ /

# determine the s6 overlay major version in use, remove any uneeded config
#   v2.* uses /etc/s6,  v3.* uses /etc/s6-overlay
RUN if [ -d "/etc/s6" ]; then \
    rm -rvf /etc/s6-overlay 2>/dev/null; \
  elif [ -d "/etc/s6-overlay" ]; then \
    rm -rvf /etc/cont-init.d /etc/services.d /etc/fix-attrs.d 2>/dev/null; \
  fi

ARG DEBIAN_RELEASE
RUN echo "DEB_RELEASE=$(echo ${DEBIAN_RELEASE})" >> /etc/contenv_extra

RUN rm -f "/usr/bin/qemu-${QEMU_ARCH}-static" >/dev/null 2>&1

## build the final image
#
FROM "moonbuggy2000/scratch:${TARGET_ARCH_TAG}"

COPY --from=builder / /

ENTRYPOINT ["/init"]
