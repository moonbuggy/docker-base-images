# syntax=docker/dockerfile:1.3-labs

ARG TARGET_VERSION="3.14.2"
ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

ARG TARGET_ARCH_TAG="amd64"

ARG FROM_IMAGE="alpine:${TARGET_VERSION}"


## get s6 overlay
FROM "moonbuggy2000/s6:${S6_VERSION}-${S6_ARCH}" AS s6

## collect everything we need
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR=""
ARG QEMU_ARCH=""
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

# enable use of TZ enviornment variable
RUN apk -U add --no-cache tzdata

COPY --from=s6 / /
COPY root/ /

# determine the s6 overlay major version in use, remove any uneeded config
#   v2.* uses /etc/s6,  v3.* uses /etc/s6-overlay
RUN if [ -d "/etc/s6" ]; then \
    rm -rvf /etc/s6-overlay 2>/dev/null; \
  elif [ -d "/etc/s6-overlay" ]; then \
    rm -rvf /etc/cont-init.d /etc/services.d /etc/fix-attrs.d 2>/dev/null; \
  fi


# if we want to inject 'contenv' deeper in the init process:
#
# need to COPY via a temporary directory because a second COPY to / overwrites
# the entire previous 'COPY --from=s6' file structure and we lose s6
# ARG TEMP_ROOT="/temp-root"
# COPY ./root "${TEMP_ROOT}"
#
# determine the s6 overlay major version in use, remove any uneeded config
# the use 'find' to merge TEMP_ROOT with the root path
#
#   v2.* uses /etc/s6,  v3.* uses /etc/s6-overlay
#
# RUN if [ -d "/etc/s6" ]; then \
#     rm -rvf "${TEMP_ROOT}/etc/s6-overlay"; \
#   elif [ -d "/etc/s6-overlay" ]; then \
#     rm -rvf "${TEMP_ROOT}/etc/cont-init.d" "${TEMP_ROOT}/etc/services.d"; \
#   fi \
#   && cd "${TEMP_ROOT}" \
#   && find . -type d -exec mkdir -p /\{} \; \
#   && find . -type f -exec mv \{} /\{} \; \
#   && cd / \
#   && rm -rf "${TEMP_ROOT}"

ARG TARGET_VERSION
RUN add-contenv "ALPINE_VERSION=${TARGET_VERSION}"

# remove QEMU static binaries
RUN rm -f "/usr/bin/qemu-${QEMU_ARCH}-static" >/dev/null 2>&1


## build the final image
FROM "moonbuggy2000/scratch:${TARGET_ARCH_TAG}"

COPY --from=builder / /

ENTRYPOINT ["/init"]
