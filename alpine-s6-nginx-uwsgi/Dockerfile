ARG NGINX_VERSION="1.18"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6-nginx:${NGINX_VERSION}"

ARG TARGET_ARCH_TAG="amd64"

## build the image
#
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR=""
ARG QEMU_ARCH=""
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

COPY ./etc /etc

# determine the s6 overlay major version in use, remove any uneeded config
#   v2.* uses /etc/s6,  v3.* uses /etc/s6-overlay
RUN if [ -d "/etc/s6" ]; then \
    rm -rvf /etc/s6-overlay 2>/dev/null; \
  elif [ -d "/etc/s6-overlay" ]; then \
    rm -rvf /etc/cont-init.d /etc/services.d /etc/fix-attrs.d 2>/dev/null; \
  fi

# remove QEMU static binaries
RUN rm -f "/usr/bin/qemu-${QEMU_ARCH}-static" >/dev/null 2>&1


## build the final image
#
FROM "moonbuggy2000/scratch:${TARGET_ARCH_TAG}"

COPY --from=builder / /

ENTRYPOINT ["/init"]
