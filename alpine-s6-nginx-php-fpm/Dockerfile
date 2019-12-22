ARG ALPINE_VERSION=3.10.3

FROM moonbuggy2000/alpine-s6:$ALPINE_VERSION

ARG PHP_VERSION=7.3
ARG PHP_PACKAGE=php7
ARG NGINX_VERSION=1.16

ENV PHP_VERSION=${PHP_VERSION} \
	PHP_PACKAGE=${PHP_PACKAGE} \
	NGINX_VERSION=${NGINX_VERSION}

RUN apk add --no-cache \
		${PHP_PACKAGE}=~${PHP_VERSION} ${PHP_PACKAGE}-fpm=~${PHP_VERSION} \
		nginx=~${NGINX_VERSION} \
		curl

COPY ./etc/cont-init.d /etc/cont-init.d
COPY ./etc/nginx /etc/nginx
COPY ./etc/${PHP_PACKAGE} /etc/${PHP_PACKAGE}
COPY ./etc/services.d /etc/services.d

ENTRYPOINT ["/init"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping
