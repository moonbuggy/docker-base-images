# syntax = docker/dockerfile:1.4.0

ARG PYTHON_VERSION="3.10.6"
ARG ALPINE_VERSION="3.16"

ARG FROM_IMAGE="python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}"
ARG BUILDPLATFORM="linux/amd64"

## get s6-add-contenv
#
FROM --platform="${BUILDPLATFORM}" moonbuggy2000/s6-add-contenv:s6-overlay-v3 AS add-contenv

## build the image
#
FROM "${FROM_IMAGE}"

# install s6-overlay and enable use of TZ enviornment variable
# use a local APK caching proxy, if one is provided
ARG APK_PROXY=""

ARG ALPINE_VERSION
ARG PYTHON_VERSION
RUN if [ ! -z "${APK_PROXY}" ]; then \
    alpine_minor_ver="$(grep -o 'VERSION_ID.*' /etc/os-release | grep -oE '([0-9]+\.[0-9]+)')"; \
    mv /etc/apk/repositories /etc/apk/repositories.bak; \
    echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/main" >/etc/apk/repositories; \
    echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/community" >>/etc/apk/repositories; \
	fi \
  && apk -U add --no-cache \
    s6-overlay \
    tzdata \
  && (mv -f /etc/apk/repositories.bak /etc/apk/repositories >/dev/null 2>&1 || true) \
  && echo "ALPINE_VERSION=${ALPINE_VERSION}" >> /etc/contenv_extra \
  && echo "PYTHON_VERSION=$(echo ${PYTHON_VERSION} | awk -F \. '{print $1"."$2}')" >> /etc/contenv_extra \
  && echo "PYTHON_PACKAGE=python$(echo ${PYTHON_VERSION} | awk -F \. '{print $1}')" >> /etc/contenv_extra

COPY --from=add-contenv / /
COPY root/ /

ENTRYPOINT ["/init"]
