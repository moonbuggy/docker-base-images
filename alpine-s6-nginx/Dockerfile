# syntax = docker/dockerfile:1.4.0

ARG ALPINE_VERSION="3.16"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6:${ALPINE_VERSION}"

ARG NGINX_VERSION="1.22"

## prepare config files
#
FROM "${FROM_IMAGE}" AS config

COPY root/ /config_root/
WORKDIR /config_root/etc/

# determine the s6 overlay major version in use, remove any uneeded config
#   v2.* uses /etc/s6,  v3.* uses /etc/s6-overlay
RUN if [ -d "/etc/s6" ]; then \
    echo "*** Removing s6-overlay V3 init scripts.."; \
    rm -rvf s6-overlay 2>/dev/null; \
  elif [ -d "/etc/s6-overlay" ]; then \
    echo "*** Removing s6-overlay V2 init scripts.."; \
    rm -rvf cont-init.d services.d fix-attrs.d 2>/dev/null; \
  fi

# configure environment
ARG NGINX_VERSION
RUN add-contenv \
		NGINX_VERSION="${NGINX_VERSION}" \
		&& cp /etc/contenv_extra ./


## build the image
#
FROM "${FROM_IMAGE}"

ARG NGINX_VERSION
ARG	WEB_ROOT="/var/www/html"
RUN apk add --no-cache \
		nginx=~"${NGINX_VERSION}" \
		shadow \
	&& rm -rf /etc/nginx/conf.d 2>/dev/null \
	&& ln -sf /etc/nginx/http.d /etc/nginx/conf.d \
	&& rm -rf /var/www/localhost 2>/dev/null \
	&& mkdir -p "${WEB_ROOT}" \
	&& adduser -DH -G www-data www-data \
	&& chown -R www-data:www-data "${WEB_ROOT}" \
	&& chown -R www-data:www-data /var/lib/nginx

COPY --from=config /config_root/ /

ARG NGINX_PORT="8080"
ENV NGINX_PORT="${NGINX_PORT}" \
		WEB_ROOT="${WEB_ROOT}"

EXPOSE "${NGINX_PORT}"

ENTRYPOINT ["/init"]

HEALTHCHECK --start-period=10s --timeout=10s CMD /healthcheck.sh
