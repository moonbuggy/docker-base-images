# syntax = docker/dockerfile:1.4.0

ARG ALPINE_VERSION="3.20"
ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"

## build the image
#
FROM "${FROM_IMAGE}" AS builder

# use a local APK caching proxy, if one is provided
ARG APK_PROXY=""

RUN if [ ! -z "${APK_PROXY}" ]; then \
    alpine_minor_ver="$(grep -o 'VERSION_ID.*' /etc/os-release | grep -oE '([0-9]+\.[0-9]+)')"; \
    mv /etc/apk/repositories /etc/apk/repositories.bak; \
    echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/main" >/etc/apk/repositories; \
    echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/community" >>/etc/apk/repositories; \
	fi \
	&& apk add --no-cache \
		curl \
		git \
		jq \
  && (mv -f /etc/apk/repositories.bak /etc/apk/repositories >/dev/null 2>&1 || true)
