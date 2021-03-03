ARG ALPINE_VERSION="3.13.2"
ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"

## build the image
#
FROM ${FROM_IMAGE}

COPY ./root /

ARG ALPINE_VERSION="${ALPINE_VERSION}"
ARG S6_VERSION="v2.2.0.3"
ARG S6_ARCH="amd64"

RUN add-contenv ALPINE_VERSION="${ALPINE_VERSION}" \
	&& wget -qO /installer "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}-installer" \
	&& chmod a+x /installer \
	&& /installer / >/dev/null 2>&1 \
	&& rm -rf /installer

ENTRYPOINT ["/init"]
