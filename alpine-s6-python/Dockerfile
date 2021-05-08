ARG TARGET_VERSION="3.9"
ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

ARG FROM_IMAGE="python:${TARGET_VERSION}-alpine"

ARG TARGET_ARCH_TAG="amd64"

## get s6 overlay
FROM "moonbuggy2000/s6:${S6_VERSION}-${S6_ARCH}" AS s6

## collect everything we need
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR
ARG QEMU_ARCH
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

COPY --from=s6 / /
COPY ./root/ /

ARG TARGET_VERSION
RUN echo "PYTHON_VERSION=$(echo ${TARGET_VERSION} | awk -F \. '{print $1"."$2}')" >> /etc/contenv_extra \
	&& echo "PYTHON_PACKAGE=python$(echo ${TARGET_VERSION} | awk -F \. '{print $1}')" >> /etc/contenv_extra

RUN rm -f "/usr/bin/qemu-${QEMU_ARCH}-static" >/dev/null 2>&1

## build the final image
FROM "moonbuggy2000/scratch:${TARGET_ARCH_TAG}"

COPY --from=builder / /

ENTRYPOINT ["/init"]
