# syntax = docker/dockerfile:1.4.0

ARG NODE_VERSION="18"
ARG ALPINE_VERSION="3.16"

ARG FROM_IMAGE="node:${NODE_VERSION}-alpine${ALPINE_VERSION}"
ARG BUILDPLATFORM="linux/amd64"

## get s6-add-contenv
#
FROM --platform="${BUILDPLATFORM}" moonbuggy2000/s6-add-contenv:s6-overlay-v3 AS add-contenv

## prepare config files
#
FROM --platform="${BUILDPLATFORM}" "${FROM_IMAGE}" AS config

COPY root/ /config_root/
COPY --from=add-contenv / /config_root/

WORKDIR /config_root/etc/
ARG NODE_VERSION
RUN echo "NODE_VERSION=${NODE_VERSION}" >> contenv_extra

## build the image
#
FROM "${FROM_IMAGE}"

# install s6-overlay and enable use of TZ enviornment variable
# use a local APK caching proxy, if one is provided
ARG APK_PROXY=""
ARG ALPINE_MINOR
RUN if [ ! -z "${APK_PROXY}" ]; then \
    mv /etc/apk/repositories /etc/apk/repositories.bak; \
		echo "${APK_PROXY}/alpine/v${ALPINE_MINOR}/main" >/etc/apk/repositories; \
		echo "${APK_PROXY}/alpine/v${ALPINE_MINOR}/community" >>/etc/apk/repositories; \
	fi \
  && apk -U add --no-cache \
    s6-overlay \
    tzdata \
  && (mv -f /etc/apk/repositories.bak /etc/apk/repositories || true)

COPY --from=config /config_root/ /

ENTRYPOINT ["/init"]
