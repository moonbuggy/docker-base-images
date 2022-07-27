# syntax = docker/dockerfile:1.4.0

ARG BUILDPLATFORM="linux/amd64"
FROM --platform=${BUILDPLATFORM} moonbuggy2000/fetcher:latest AS builder

WORKDIR /contenv-root/
COPY root/ ./

ARG S6_MAJOR_VERSION="3"
RUN chmod a+x etc/cont-init.d/00-add-contenv \
    etc/s6-overlay/s6-rc.d/add-contenv/up \
    usr/local/bin/add-contenv \
  && case ${S6_MAJOR_VERSION} in \
    "2") rm -rvf etc/s6-overlay 2>/dev/null ;; \
    "3") rm -rvf etc/cont-init.d 2>/dev/null ;; \
  esac

FROM moonbuggy2000/scratch
COPY --from=builder contenv-root/ /

# if we want to inject 'contenv' deeper in the init process:
#
# need to COPY via a temporary directory because a second COPY to / overwrites
# the entire previous 'COPY --from=s6' file structure and we lose s6
# ARG TEMP_ROOT="/temp-root"
# COPY ./contenv-root "${TEMP_ROOT}"
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
