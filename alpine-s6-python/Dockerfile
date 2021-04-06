ARG TARGET_VERSION="3.9"
ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

ARG FROM_IMAGE="python:${TARGET_VERSION}-alpine"

## get s6 overlay
FROM "moonbuggy2000/s6:${S6_VERSION}-${S6_ARCH}" AS s6

## collect everything we need
FROM "moonbuggy2000/fetcher:latest" AS builder

COPY --from=s6 /s6-root /builder-root
COPY ./root /builder-root

ARG TARGET_VERSION
RUN echo "PYTHON_VERSION=$(echo ${TARGET_VERSION} | awk -F \. '{print $1"."$2}')" >> /builder-root/etc/contenv_extra \
	&& echo "PYTHON_PACKAGE=python$(echo ${TARGET_VERSION} | awk -F \. '{print $1}')" >> /builder-root/etc/contenv_extra

## build the image
FROM "${FROM_IMAGE}"

COPY --from=builder ./builder-root/ /

ENTRYPOINT ["/init"]
