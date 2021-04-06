ARG ALPINE_VERSION="3.13.2"
ARG SOURCE_TAG="${ALPINE_VERSION}"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6:${SOURCE_TAG}"

## build the image
#
FROM "${FROM_IMAGE}" AS builder

ARG NGINX_VERSION=1.18
ARG NGINX_PORT=8080

ENV	NGINX_PORT="${NGINX_PORT}" \
		WEB_ROOT="/var/www/html"

RUN add-contenv NGINX_VERSION="${NGINX_VERSION}" \
	&& apk add --no-cache \
		nginx=~"${NGINX_VERSION}" \
		shadow \
	&& adduser -DH -G www-data www-data \
	&& rm -rf /var/www/localhost \
	&& mkdir -p "${WEB_ROOT}"

COPY ./etc /etc

EXPOSE ${NGINX_PORT}

HEALTHCHECK --start-period=10s --timeout=10s \
	CMD wget --quiet --tries=1 --spider http://127.0.0.1:8080/nginx-ping && echo 'okay' || exit 1
