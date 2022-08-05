# syntax = docker/dockerfile:1.4.0

ARG ALPINE_VERSION="3.16"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6:${ALPINE_VERSION}"

## build the image
#
FROM "${FROM_IMAGE}"

ARG NGINX_VERSION="1.22"
ARG	WEB_ROOT="/var/www/html"
RUN apk -U add --no-cache \
		nginx=~"${NGINX_VERSION}" \
		shadow \
	&& rm -rf /etc/nginx/conf.d 2>/dev/null \
	&& ln -sf /etc/nginx/http.d /etc/nginx/conf.d \
	&& rm -rf /var/www/localhost 2>/dev/null \
	&& mkdir -p "${WEB_ROOT}" \
	&& adduser -DH -G www-data www-data \
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
