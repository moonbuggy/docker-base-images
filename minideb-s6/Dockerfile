ARG MINIDEB_RELEASE=buster

FROM bitnami/minideb:$MINIDEB_RELEASE

ARG S6_VERSION=v2.0.0.1
ARG S6_ARCH=amd64

ARG MINIDEB_RELEASE

COPY ./etc /etc
COPY ./usr /usr

RUN add-contenv MINIDEB_RELEASE=${MINIDEB_RELEASE} \
	&& apt-get update \
	&& BUILD_PACKAGES="curl ca-certificates" \
	&& apt-get install -qy --no-install-recommends $BUILD_PACKAGES \
	&& curl -L -s https://github.com/just-containers/s6-overlay/releases/download/$S6_VERSION/s6-overlay-$S6_ARCH.tar.gz | tar xzf - -C / \
	&& apt-get remove --purge -qy $BUILD_PACKAGES $(apt-mark showauto) \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/init"]
