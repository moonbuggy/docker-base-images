# syntax = docker/dockerfile:1.4.0

ARG ALPINE_VERSION="3.13"
ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"

## build the image
#
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR
ARG QEMU_ARCH
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

# use a local APK caching proxy, if one is provided
ARG APK_PROXY=""
ARG ALPINE_MINOR="${ALPINE_VERSION}"
RUN if [ ! -z "${APK_PROXY}" ]; then \
    mv /etc/apk/repositories /etc/apk/repositories.bak; \
		echo "${APK_PROXY}/alpine/v${ALPINE_MINOR}/main" >/etc/apk/repositories; \
		echo "${APK_PROXY}/alpine/v${ALPINE_MINOR}/community" >>/etc/apk/repositories; \
	fi \
	&& apk add --no-cache \
		curl \
		git \
		jq \
  && (mv -f /etc/apk/repositories.bak /etc/apk/repositories || true)

# in this case we'll retain the QEMU static binaries
