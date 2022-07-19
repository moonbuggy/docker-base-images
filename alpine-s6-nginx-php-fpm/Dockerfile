# syntax = docker/dockerfile:1.4.0

ARG ALPINE_VERSION="3.15"
ARG SOURCE_TAG="alpine${ALPINE_VERSION}"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6-nginx:${SOURCE_TAG}"

ARG PHP_VERSION="7.4"
ARG PHP_PACKAGE="php7"
ARG PHP_BINARY="php-fpm7"

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

# remove unecessary php configs
ARG PHP_PACKAGE
RUN rm -rvf $(find . -type d -name 'php*' -maxdepth 1 | grep -v ".*${PHP_PACKAGE}\$" | xargs)

# patch config for PHP 7.2
ARG PHP_VERSION
RUN [ "${PHP_VERSION}" != "7.2" ] \
  || sed -re 's|^(decorate_workers_output.*)|;\1|' -i php7/php-fpm.conf

# configure environment
ARG PHP_BINARY
RUN add-contenv \
		PHP_VERSION=${PHP_VERSION} \
		PHP_PACKAGE=${PHP_PACKAGE} \
		PHP_BINARY=${PHP_BINARY} \
	&& cp /etc/contenv_extra ./


## build the image
#
FROM "${FROM_IMAGE}"

ARG PHP_VERSION
ARG PHP_PACKAGE
RUN apk add --no-cache \
		${PHP_PACKAGE}=~${PHP_VERSION} \
		${PHP_PACKAGE}-fpm=~${PHP_VERSION}

COPY --from=config /config_root/ /

ARG NGINX_PORT="8080"
EXPOSE "${NGINX_PORT}"

ENTRYPOINT ["/init"]

HEALTHCHECK --start-period=10s --timeout=10s CMD /healthcheck.sh
