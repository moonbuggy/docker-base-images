# syntax = docker/dockerfile:1.4.0

ARG PYPY_PYTHON_VERSION="3.6"
ARG ALPINE_VERSION="3.11"
ARG FROM_IMAGE="jamiehewland/alpine-pypy:${PYPY_PYTHON_VERSION}-alpine${ALPINE_VERSION}"

ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

## get s6 overlay
#
FROM "moonbuggy2000/s6:${S6_VERSION}-alpine${ALPINE_VERSION}-${S6_ARCH}" AS s6

## build the image
#
FROM "${FROM_IMAGE}"

# enable use of TZ enviornment variable
RUN apk -U add --no-cache tzdata

COPY --from=s6 / /
COPY ./root /

ARG ALPINE_VERSION
RUN add-contenv ALPINE_VERSION="${ALPINE_VERSION}" \
  && if [ ! -f /usr/local/bin/pypy ] && [ -f /usr/local/bin/pypy3 ]; then \
    ln -s /usr/local/bin/pypy3 /usr/local/bin/pypy; \
  fi

ENTRYPOINT ["/init"]
