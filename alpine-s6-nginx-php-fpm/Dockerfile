ARG ALPINE_VERSION=3.10.3

FROM moonbuggy2000/alpine-s6-nginx:$ALPINE_VERSION

ARG PHP_VERSION=7.3
ARG PHP_PACKAGE=php7

ENV PHP_VERSION=${PHP_VERSION} \
	PHP_PACKAGE=${PHP_PACKAGE} 

RUN apk add --no-cache \
		${PHP_PACKAGE}=~${PHP_VERSION} \
		${PHP_PACKAGE}-fpm=~${PHP_VERSION}

COPY ./etc/cont-init.d /etc/cont-init.d
COPY ./etc/nginx /etc/nginx
COPY ./etc/${PHP_PACKAGE} /etc/${PHP_PACKAGE}
COPY ./etc/services.d /etc/services.d

ENTRYPOINT ["/init"]

HEALTHCHECK --start-period=10s --timeout=10s \
	CMD wget --quiet --tries=1 --spider http://127.0.0.1:8080/fpm-ping && echo 'okay' || exit 1
