# syntax = docker/dockerfile:1.4.0

ARG ALPINE_VERSION="3.16.0"
ARG S6_VERSION="3.1.0.1"

ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"

## prepare config files
#
FROM "${FROM_IMAGE}" AS config

COPY root/ /config_root/

WORKDIR /config_root/etc/

# determine the s6 overlay major version in use, remove any uneeded config
#   v2.* uses /etc/s6,  v3.* uses /etc/s6-overlay
RUN case "${S6_VERSION%%.*}" in \
    "2") rm -rvf s6-overlay 2>/dev/null ;; \
    *) rm -rvf cont-init.d services.d fix-attrs.d 2>/dev/null ;; \
  esac

# configure environment
ARG ALPINE_VERSION
RUN echo "ALPINE_VERSION=${ALPINE_VERSION}" >> contenv_extra

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


## build the image
#
FROM "${FROM_IMAGE}"

# enable use of TZ enviornment variable and install s6-overlay
RUN apk -U add --no-cache \
    s6-overlay \
    tzdata

COPY --from=config /config_root/ /

ENTRYPOINT ["/init"]
