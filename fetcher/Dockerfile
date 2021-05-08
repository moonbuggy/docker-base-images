ARG ALPINE_VERSION="3.13"
ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"

## build the image
#
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR
ARG QEMU_ARCH
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

RUN apk add --no-cache \ 
		curl \
		git \
		jq

# in this case we'll retain the QEMU static binaries
