ARG ALPINE_VERSION=3.10.3

FROM moonbuggy2000/alpine-s6:$ALPINE_VERSION

ARG ALPINE_VERSION
ARG NGINX_VERSION=1.16

ENV NGINX_VERSION=${NGINX_VERSION} \
	WEB_ROOT=/var/www/html

RUN apk add --no-cache \
		nginx=~${NGINX_VERSION} \
		shadow \
	&& adduser -DH -G www-data www-data \
	&& rm -rf /var/www/localhost \
	&& mkdir -p ${WEB_ROOT}

COPY ./etc /etc

EXPOSE 8080

ENTRYPOINT ["/init"]

HEALTHCHECK --start-period=10s --timeout=10s \
	CMD wget --quiet --tries=1 --spider http://127.0.0.1:8080/nginx-ping && echo 'okay' || exit 1
