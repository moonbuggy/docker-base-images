ARG MINIDEB_RELEASE=buster

FROM bitnami/minideb:$MINIDEB_RELEASE

ARG S6_VERSION=v1.22.1.0
ARG S6_ARCH=amd64

ARG MINIDEB_RELEASE
ENV MINIDEB_RELEASE=${MINIDEB_RELEASE}

RUN set -x \
	&& apt-get update \
	&& BUILD_PACKAGES="curl ca-certificates" \
	&& apt-get install -qy --no-install-recommends $BUILD_PACKAGES \
	&& curl -L -s https://github.com/just-containers/s6-overlay/releases/download/$S6_VERSION/s6-overlay-$S6_ARCH.tar.gz | tar xvzf - -C / \
	&& apt-get remove --purge -qy $BUILD_PACKAGES $(apt-mark showauto) \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/init"]
