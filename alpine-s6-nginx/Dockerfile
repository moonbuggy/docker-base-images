ARG ALPINE_VERSION=3.10.3

FROM moonbuggy2000/alpine-s6:$ALPINE_VERSION

ARG ALPINE_VERSION
ARG NGINX_VERSION=1.16

ENV NGINX_VERSION=${NGINX_VERSION}

RUN apk add --no-cache \
		nginx=~${NGINX_VERSION} \
		shadow \
	&& adduser -DH -G www-data www-data \
	&& mkdir -p /var/www/html

COPY ./etc /etc

EXPOSE 8080

ENTRYPOINT ["/init"]

HEALTHCHECK --start-period=10s --timeout=10s \
	CMD wget --quiet --tries=1 --spider http://127.0.0.1:8081/healthcheck || exit 1
