# syntax = docker/dockerfile:1.4.0

ARG PYTHON_VERSION="3.10.6"
ARG FROM_IMAGE="python:${PYTHON_VERSION}-slim"

ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

ARG BUILDPLATFORM="linux/amd64"

## get s6 overlay
#
FROM --platform="${BUILDPLATFORM}" "moonbuggy2000/s6-overlay:${S6_VERSION}-${S6_ARCH}" AS s6-overlay

## build the image
#
FROM "${FROM_IMAGE}"

# when using buildx apt-get throws errors about missing binaries in some arches
ARG DEBIAN_RELEASE
ARG PYTHON_VERSION
RUN { [ ! -f "/usr/sbin/dpkg-deb" ] && ln -s /usr/bin/dpkg-deb /usr/sbin/dpkg-deb; } \
  && { [ ! -f "/usr/sbin/dpkg-split" ] && ln -s /usr/bin/dpkg-split /usr/sbin/dpkg-split; } \
  && { [ ! -f "/usr/sbin/rm" ] && ln -s /bin/rm /usr/sbin/rm; } \
  && { [ ! -f "/usr/sbin/tar" ] && ln -s /bin/tar /usr/sbin/tar; } \
  && echo "PYTHON_VERSION=$(echo ${PYTHON_VERSION} | awk -F \. '{print $1"."$2}')" >> /etc/contenv_extra \
  && echo "PYTHON_PACKAGE=python$(echo ${PYTHON_VERSION} | awk -F \. '{print $1}')" >> /etc/contenv_extra

COPY --from=s6-overlay / /
COPY root/ /

ENTRYPOINT ["/init"]
