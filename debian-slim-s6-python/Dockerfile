# syntax = docker/dockerfile:1.4.0

ARG PYTHON_VERSION="3.10.5"
ARG FROM_IMAGE="python:${PYTHON_VERSION}-slim"

ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

## get s6 overlay
#
FROM "moonbuggy2000/s6:${S6_VERSION}-${S6_ARCH}" AS s6

## prepare config files
#
FROM "${FROM_IMAGE}" AS config

COPY --from=s6 / /config_root/
COPY root/ /config_root/

WORKDIR /config_root/etc/

# determine the s6 overlay major version in use, remove any uneeded config
#   v2.* uses /etc/s6,  v3.* uses /etc/s6-overlay
RUN if [ -d "s6" ]; then \
    echo "*** Removing s6-overlay V3 init scripts.."; \
    rm -rvf s6-overlay 2>/dev/null; \
  elif [ -d "s6-overlay" ]; then \
    echo "*** Removing s6-overlay V2 init scripts.."; \
    rm -rvf cont-init.d services.d fix-attrs.d 2>/dev/null; \
  fi

# configure environment
ARG DEBIAN_RELEASE
ARG PYTHON_VERSION
RUN echo "PYTHON_VERSION=$(echo ${PYTHON_VERSION} | awk -F \. '{print $1"."$2}')" >> contenv_extra \
  && echo "PYTHON_PACKAGE=python$(echo ${PYTHON_VERSION} | awk -F \. '{print $1}')" >> contenv_extra


## build the image
#
FROM "${FROM_IMAGE}"

COPY --from=config /config_root/ /

# when using buildx apt-get throws errors about missing binaries in some arches \
RUN { [ ! -f "/usr/sbin/dpkg-deb" ] && ln -s /usr/bin/dpkg-deb /usr/sbin/dpkg-deb; } \
  && { [ ! -f "/usr/sbin/dpkg-split" ] && ln -s /usr/bin/dpkg-split /usr/sbin/dpkg-split; } \
  && { [ ! -f "/usr/sbin/rm" ] && ln -s /bin/rm /usr/sbin/rm; } \
  && { [ ! -f "/usr/sbin/tar" ] && ln -s /bin/tar /usr/sbin/tar; }

ENTRYPOINT ["/init"]
