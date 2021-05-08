ARG MINIDEB_RELEASE="buster"
ARG FROM_IMAGE="bitnami/minideb:${MINIDEB_RELEASE}"

ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

ARG TARGET_ARCH_TAG

## get s6 overlay
FROM "moonbuggy2000/s6:${S6_VERSION}-${S6_ARCH}" AS s6

## build the image
#
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR
ARG QEMU_ARCH
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

COPY --from=s6 / /
COPY ./root /

ARG DEBIAN_RELEASE="${DEBIAN_RELEASE}"
RUN add-contenv "MINIDEB_RELEASE=${MINIDEB_RELEASE}"

RUN rm -f "/usr/bin/qemu-${QEMU_ARCH}-static" >/dev/null 2>&1

## build the final image
FROM "moonbuggy2000/scratch:${TARGET_ARCH_TAG}"

COPY --from=builder / /

ENTRYPOINT ["/init"]
