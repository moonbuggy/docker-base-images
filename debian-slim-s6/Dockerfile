# syntax = docker/dockerfile:1.4.0

ARG DEBIAN_RELEASE="bookworm"
ARG DEBIAN_VERISON="12.7"
ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

ARG FROM_IMAGE="debian:${DEBIAN_VERSION}-slim"

## get s6 overlay
#
FROM --platform="${BUILDPLATFORM}" "moonbuggy2000/s6-overlay:${S6_VERSION}-${S6_ARCH}" AS s6-overlay

## build the image
#
FROM "${FROM_IMAGE}"

COPY --from=s6-overlay / /
COPY root/ /

# when using buildx apt-get throws errors about missing binaries in some arches
ARG DEBIAN_RELEASE
ARG DEBIAN_VERSION
RUN { [ ! -f "/usr/sbin/dpkg-deb" ] && ln -s /usr/bin/dpkg-deb /usr/sbin/dpkg-deb; } \
  && { [ ! -f "/usr/sbin/dpkg-split" ] && ln -s /usr/bin/dpkg-split /usr/sbin/dpkg-split; } \
  && { [ ! -f "/usr/sbin/rm" ] && ln -s /bin/rm /usr/sbin/rm; } \
  && { [ ! -f "/usr/sbin/tar" ] && ln -s /bin/tar /usr/sbin/tar; } \
  && echo "DEB_RELEASE=$(echo ${DEBIAN_RELEASE})" >> /etc/contenv_extra \
  && echo "DEB_VERSION=$(echo ${DEBIAN_VERSION})" >> /etc/contenv_extra

ENTRYPOINT ["/init"]
