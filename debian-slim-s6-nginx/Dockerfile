ARG DEBIAN_VERSION="buster"
ARG FROM_IMAGE="moonbuggy2000/debian-slim-s6:${DEBIAN_VERSION}"

ARG NGINX_PORT="8080"

ARG TARGET_ARCH_TAG="amd64"

## build the image
#
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR=".qemu_static"
ARG QEMU_ARCH="blah"
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

ARG NGINX_VERSION="1.14"
ARG	WEB_ROOT="/var/www/html"
RUN export DEBIAN_FRONTEND="noninteractive" \
	&& apt update \
	&& apt-get install -qy --no-install-recommends \
		nginx="${NGINX_VERSION}*" \
	&& rm -rf /var/www/localhost >/dev/null 2>&1 \
	&& mkdir -p "${WEB_ROOT}" \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG	NGINX_PORT
RUN add-contenv \
		NGINX_VERSION="${NGINX_VERSION}" \
		NGINX_PORT="${NGINX_PORT}" \
		WEB_ROOT="${WEB_ROOT}"

COPY ./etc /etc

RUN rm -f "/usr/bin/qemu-${QEMU_ARCH}-static" >/dev/null 2>&1

## build the final image
FROM "moonbuggy2000/scratch:${TARGET_ARCH_TAG}"

COPY --from=builder / /

ARG NGINX_PORT="8080"
EXPOSE ${NGINX_PORT}

ENTRYPOINT ["/init"]

HEALTHCHECK --start-period=10s --timeout=10s \
	CMD wget --quiet --tries=1 --spider "http://127.0.0.1:${NGINX_PORT}/nginx-ping" && echo 'okay' || exit 1
