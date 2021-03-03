ARG PYPY_PYTHON_VERSION="3.6"
ARG ALPINE_VERSION="3.11"
ARG FROM_IMAGE="jamiehewland/alpine-pypy:${PYPY_PYTHON_VERSION}-alpine${ALPINE_VERSION}"

## build the image
#
FROM ${FROM_IMAGE}

ARG S6_VERSION=v2.2.0.3
ARG S6_ARCH=amd64

ARG ALPINE_VERSION

COPY ./root /

RUN add-contenv ALPINE_VERSION=${ALPINE_VERSION} \
	&& wget -qO /installer "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}-installer" \
	&& chmod a+x /installer \
	&& /installer / >/dev/null 2>&1 \
	&& rm -rf /installer

ENTRYPOINT ["/init"]
