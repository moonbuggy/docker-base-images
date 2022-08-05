# syntax = docker/dockerfile:1.4.0

ARG DEBIAN_VERSION="bullseye"
ARG FROM_IMAGE="moonbuggy2000/debian-slim-s6:${DEBIAN_VERSION}"

## build the image
#
FROM "${FROM_IMAGE}"

ARG NGINX_VERSION="1.18"
ARG	WEB_ROOT="/var/www/html"
RUN export DEBIAN_FRONTEND="noninteractive" \
	&& apt update \
	&& apt-get install -qy --no-install-recommends \
		nginx="${NGINX_VERSION}*" \
    wget \
	&& apt-get clean \
	&& rm -rf /etc/nginx/conf.d 2>/dev/null \
	&& ln -sf /etc/nginx/http.d /etc/nginx/conf.d \
	&& rm -rf /var/www/localhost >/dev/null 2>&1 \
	&& mkdir -p "${WEB_ROOT}" \
	&& chown -R www-data:www-data "${WEB_ROOT}" \
  && chown -R www-data:www-data /var/lib/nginx \
  && add-contenv NGINX_VERSION="${NGINX_VERSION}"

COPY root/ /

ARG NGINX_PORT="8080"
ENV NGINX_PORT="${NGINX_PORT}" \
		WEB_ROOT="${WEB_ROOT}"

EXPOSE "${NGINX_PORT}"

ENTRYPOINT ["/init"]

HEALTHCHECK --start-period=10s --timeout=10s CMD /healthcheck.sh
