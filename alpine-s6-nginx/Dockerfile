ARG ALPINE_VERSION="3.14"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6:${ALPINE_VERSION}"

ARG NGINX_PORT="8080"

ARG TARGET_ARCH_TAG="amd64"

## build the image
#
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR
ARG QEMU_ARCH
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

ARG NGINX_VERSION="1.20"
ARG	WEB_ROOT="/var/www/html"
RUN apk add --no-cache \
		nginx=~"${NGINX_VERSION}" \
		shadow \
	&& adduser -DH -G www-data www-data \
	&& rm -rf /var/www/localhost \
	&& mkdir -p "${WEB_ROOT}" \
	&& chown -R www-data:www-data "${WEB_ROOT}" \
	&& chown -R www-data:www-data /var/lib/nginx

ARG	NGINX_PORT
RUN add-contenv \
		NGINX_VERSION="${NGINX_VERSION}" \
		DEFAULT_NGINX_PORT="${NGINX_PORT}" \
		DEFAULT_WEB_ROOT="${WEB_ROOT}"

COPY ./etc /etc

# determine the s6 overlay major version in use, remove any uneeded config
#   v2.* uses /etc/s6,  v3.* uses /etc/s6-overlay
RUN if [ -d "/etc/s6" ]; then \
    rm -rvf /etc/s6-overlay 2>/dev/null; \
  elif [ -d "/etc/s6-overlay" ]; then \
    rm -rvf /etc/cont-init.d /etc/services.d /etc/fix-attrs.d 2>/dev/null; \
  fi

RUN rm -f "/usr/bin/qemu-${QEMU_ARCH}-static" > /dev/null 2>&1

## build the final image
FROM "moonbuggy2000/scratch:${TARGET_ARCH_TAG}"

COPY --from=builder / /

ARG NGINX_PORT
EXPOSE "${NGINX_PORT}"

ENTRYPOINT ["/init"]

HEALTHCHECK --start-period=10s --timeout=10s \
	CMD wget --quiet --tries=1 --spider "http://127.0.0.1:${NGINX_PORT}/nginx-ping" && echo 'okay' || exit 1
