# syntax = docker/dockerfile:1.4.0

ARG LIGHTTPD_VERSION="latest"
ARG FROM_IMAGE="moonbuggy2000/debian-slim-s6-lighttpd:${LIGHTTPD_VERSION}"

ARG PHP_VERSION="7.4"

## prepare config files
#
ARG BUILDPLATFORM="linux/amd64"
FROM --platform="${BUILDPLATFORM}" "${FROM_IMAGE}" AS config

COPY root/ /config_root/
WORKDIR /config_root/

# configure environment
ARG PHP_VERSION
ARG PHP_BINARY="php-cgi${PHP_VERSION}"
RUN add-contenv \
		PHP_VERSION=${PHP_VERSION} \
		PHP_BINARY=${PHP_BINARY} \
	&& cp /etc/contenv_extra ./etc/


## build the image
#
FROM "${FROM_IMAGE}"

# install PHP-CGI
# using the package name with the version included (i.e. 'php<ver>-cgi', not
# 'php-cgi') acts as a sanity check. since we're menually specifying the version
# in 'build.conf' we'll get a mismatch at some future point when the available
# version changes.
ARG PHP_VERSION
# use a local APT caching proxy, if one is provided
ARG APT_CACHE=""
RUN export DEBIAN_FRONTEND="noninteractive" \
	&& if [ ! -z "${APT_CACHE}" ]; then \
		echo "Acquire::http { Proxy \"${APT_CACHE}\"; }" > /etc/apt/apt.conf.d/proxy; fi \
	&& apt update \
	&& apt-get install -qy --no-install-recommends \
		"php${PHP_VERSION}-cgi" \
	&& apt-get clean \
	&& (rm -f /etc/apt/apt.conf.d/proxy 2>&1 || true)

COPY --from=config /config_root/ /

ARG LIGHTTPD_PORT="8080"
ARG LIGHTTPD_INDEX="index.php index.html index.htm index.lighttpd.html"
ENV LIGHTTPD_INDEX="${LIGHTTPD_INDEX}" \
	LIGHTTPD_PORT="${LIGHTTPD_PORT}" \
	WEB_ROOT="${WEB_ROOT}"

EXPOSE "${LIGHTTPD_PORT}"

ENTRYPOINT ["/init"]
