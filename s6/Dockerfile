ARG FROM_IMAGE="moonbuggy2000/fetcher:latest"

## get s6 overlay
#
FROM "moonbuggy2000/fetcher:latest" AS fetcher

ARG S6_VERSION="v2.2.0.3"
ARG S6_ARCH="amd64"

RUN mkdir /s6/ \
	&& wget --no-check-certificate -qO- "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.gz" \
		| tar xzf - -C /s6/

## build final image
#
FROM scratch

COPY --from=fetcher /s6/ /
