ARG ALPINE_VERSION="3.13.2"
ARG SOURCE_TAG="${ALPINE_VERSION}"
ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"

## build the image
#
FROM ${FROM_IMAGE}

ARG BUILD_DIR=/build

WORKDIR ${BUILD_DIR}

RUN apk -U add --no-cache \
		alpine-sdk \
		autoconf \
		bison \
		flex \
		sudo \
	&& adduser -D -h /build/ -G abuild builder \
	&& chown -R builder:abuild /build \
	&& chgrp abuild /var/cache/distfiles/ \
	&& chmod g+w /var/cache/distfiles/ \
	&& echo "builder	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
	&& echo "Set disable_coredump false" >> /etc/sudo.conf \
	&& abuild-keygen -a -i -n

USER builder

CMD ["/bin/ash"]
