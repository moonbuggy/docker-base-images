# syntax = docker/dockerfile:1.4.0

ARG PYPY_PYTHON_VERSION="3.6"
ARG ALPINE_VERSION="3.11"
ARG FROM_IMAGE="jamiehewland/alpine-pypy:${PYPY_PYTHON_VERSION}-alpine${ALPINE_VERSION}"

ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

## get s6 overlay
#
FROM "moonbuggy2000/s6-overlay:${S6_VERSION}-${S6_ARCH}" AS s6-overlay

## build the image
#
FROM "${FROM_IMAGE}"

COPY --from=s6-overlay / /

# enable use of TZ enviornment variable
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
  && (mv -f /etc/apk/repositories.bak /etc/apk/repositories || true) \
  && add-contenv ALPINE_VERSION="${ALPINE_VERSION}" \
  && if [ ! -f /usr/local/bin/pypy ] && [ -f /usr/local/bin/pypy3 ]; then \
    ln -s /usr/local/bin/pypy3 /usr/local/bin/pypy; \
  fi

COPY ./root /

ENTRYPOINT ["/init"]
