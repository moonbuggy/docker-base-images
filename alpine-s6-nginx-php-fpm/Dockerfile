ARG ALPINE_VERSION="3.13.2"
ARG SOURCE_TAG="alpine${ALPINE_VERSION}"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6-nginx:${SOURCE_TAG}"

ARG TARGET_ARCH_TAG="amd64"

## build the image
#
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR
ARG QEMU_ARCH
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

ARG PHP_VERSION="7.4"
ARG PHP_PACKAGE="php7"
COPY ./etc/nginx /etc/nginx
COPY ./etc/${PHP_PACKAGE} /etc/${PHP_PACKAGE}
COPY ./etc/cont-init.d /etc/cont-init.d
COPY ./etc/services.d /etc/services.d

RUN add-contenv \
		PHP_VERSION=${PHP_VERSION} \
		PHP_PACKAGE=${PHP_PACKAGE} \
	&& apk add --no-cache \
		${PHP_PACKAGE}=~${PHP_VERSION} \
		${PHP_PACKAGE}-fpm=~${PHP_VERSION}

RUN rm -f "/usr/bin/qemu-${QEMU_ARCH}-static" > /dev/null 2>&1

## build the final image
FROM "moonbuggy2000/scratch:${TARGET_ARCH_TAG}"

COPY --from=builder / /

ARG NGINX_PORT="8080"
EXPOSE "${NGINX_PORT}"

ENTRYPOINT ["/init"]

HEALTHCHECK --start-period=10s --timeout=10s \
	CMD wget --quiet --tries=1 --spider http://127.0.0.1:8080/fpm-ping && echo 'okay' || exit 1
