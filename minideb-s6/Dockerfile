ARG MINIDEB_RELEASE="buster"
ARG FROM_IMAGE="bitnami/minideb:${MINIDEB_RELEASE}"

## build the image
#
FROM ${FROM_IMAGE}

COPY ./root /

ARG DEBIAN_RELEASE="${DEBIAN_RELEASE}"
ARG S6_VERSION="v2.2.0.3"
ARG S6_ARCH="amd64"

RUN add-contenv MINIDEB_RELEASE=${MINIDEB_RELEASE} \
	&& apt-get update \
	&& BUILD_PACKAGES="wget" \
	&& apt-get install -qy --no-install-recommends $BUILD_PACKAGES \
	&& wget --no-check-certificate -qO /installer "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}-installer" \
	&& chmod a+x /installer \
	&& /installer / >/dev/null 2>&1 \
	&& rm -rf /installer \
	&& apt-get remove --purge -qy $BUILD_PACKAGES $(apt-mark showauto) \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/init"]