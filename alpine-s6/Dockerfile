# syntax = docker/dockerfile:1.4.0

ARG ALPINE_VERSION="3.16.1"
ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"
ARG BUILDPLATFORM="linux/amd64"

## get s6 overlay
#
FROM --platform="${BUILDPLATFORM}" "moonbuggy2000/s6-overlay:${S6_VERSION}-${S6_ARCH}" AS s6-overlay

## build the image
#
FROM "${FROM_IMAGE}"

# enable use of TZ enviornment variable# install s6-overlay and enable use of TZ enviornment variable
# use a local APK caching proxy, if one is provided
ARG APK_PROXY=""

ARG ALPINE_VERSION
RUN if [ ! -z "${APK_PROXY}" ]; then \
    alpine_minor_ver="$(grep -o 'VERSION_ID.*' /etc/os-release | grep -oE '([0-9]+\.[0-9]+)')"; \
    mv /etc/apk/repositories /etc/apk/repositories.bak; \
    echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/main" >/etc/apk/repositories; \
    echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/community" >>/etc/apk/repositories; \
	fi \
  && apk -U add --no-cache \
    tzdata \
  && (mv -f /etc/apk/repositories.bak /etc/apk/repositories >/dev/null 2>&1 || true) \
  && echo "ALPINE_VERSION=${ALPINE_VERSION}" >> /etc/contenv_extra

COPY --from=s6-overlay / /
COPY root/ /

ENTRYPOINT ["/init"]
