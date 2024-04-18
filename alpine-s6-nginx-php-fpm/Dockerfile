# syntax = docker/dockerfile:1.4.0

ARG ALPINE_VERSION="3.15"
ARG SOURCE_TAG="alpine${ALPINE_VERSION}"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6-nginx:${SOURCE_TAG}"

ARG PHP_VERSION="7.4"
ARG PHP_PACKAGE="php7"
ARG PHP_BINARY="php-fpm7"


## prepare config files
#
ARG BUILDPLATFORM="linux/amd64"
FROM --platform="${BUILDPLATFORM}" "${FROM_IMAGE}" AS config

COPY root/ /config_root/
WORKDIR /config_root/etc/

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
# use a local APK caching proxy, if one is provided
ARG APK_PROXY=""
ARG ALPINE_MINOR
RUN if [ ! -z "${APK_PROXY}" ]; then \
    mv /etc/apk/repositories /etc/apk/repositories.bak; \
		echo "${APK_PROXY}/alpine/v${ALPINE_MINOR}/main" >/etc/apk/repositories; \
		echo "${APK_PROXY}/alpine/v${ALPINE_MINOR}/community" >>/etc/apk/repositories; \
	fi \
  && apk add --no-cache \
		${PHP_PACKAGE}=~${PHP_VERSION} \
		${PHP_PACKAGE}-fpm=~${PHP_VERSION} \
  && (mv -f /etc/apk/repositories.bak /etc/apk/repositories || true)

COPY --from=config /config_root/ /

ARG NGINX_PORT="8080"
EXPOSE "${NGINX_PORT}"

ENTRYPOINT ["/init"]
