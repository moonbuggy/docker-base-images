ARG ALPINE_VERSION=3.12.0

FROM alpine:$ALPINE_VERSION 

ARG BUILD_DIR=/build

WORKDIR ${BUILD_DIR}

RUN apk add --no-cache \
		alpine-sdk \
		bison \
		flex \
	&& adduser -D -h /build/ -G abuild builder \
	&& chown -R builder:abuild /build \
	&& chgrp abuild /var/cache/distfiles/ \
	&& chmod g+w /var/cache/distfiles/ \
	&& echo "builder	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
	&& echo "Set disable_coredump false" >> /etc/sudo.conf \
	&& abuild-keygen -a -i -n

USER builder

CMD ["/bin/ash"]
