# syntax = docker/dockerfile:1.4.0

ARG DEBIAN_VERSION="bookworm"
ARG FROM_IMAGE="moonbuggy2000/debian-slim-s6:${DEBIAN_VERSION}"

## build the image
#
FROM "${FROM_IMAGE}"

ARG LIGHTTPD_VERSION="1.4.69"
ARG	WEB_ROOT="/var/www/html"

# use a local APT caching proxy, if one is provided
ARG APT_CACHE=""
ARG DEBIAN_FRONTEND=noninteractive
RUN ([ ! -z "${APT_CACHE}" ] \
    && echo "Acquire::http { Proxy \"${APT_CACHE}\"; }" >/etc/apt/apt.conf.d/proxy) \
	&& apt update \
	&& apt-get install -qy --no-install-recommends \
		lighttpd="${LIGHTTPD_VERSION}*" \
		wget \
	&& apt-get clean \
	&& (rm -f /etc/apt/apt.conf.d/proxy >/dev/null 2>&1 || true) \
	&& rm -rf /var/www/localhost >/dev/null 2>&1 \
	&& mkdir -p "${WEB_ROOT}" \
	&& chown -R www-data:www-data "${WEB_ROOT}" \
	&& add-contenv LIGHTTPD_VERSION="${LIGHTTPD_VERSION}"

COPY root/ /

ARG LIGHTTPD_INDEX="index.html index.htm index.lighttpd.html"
ARG LIGHTTPD_PORT="8080"
ENV LIGHTTPD_INDEX="${LIGHTTPD_INDEX}" \
	LIGHTTPD_PORT="${LIGHTTPD_PORT}" \
	WEB_ROOT="${WEB_ROOT}"

EXPOSE "${LIGHTTPD_PORT}"

ENTRYPOINT ["/init"]

HEALTHCHECK --start-period=10s --timeout=10s CMD /healthcheck.sh
