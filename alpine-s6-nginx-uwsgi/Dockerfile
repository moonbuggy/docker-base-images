ARG ALPINE_VERSION="3.12.3"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6-nginx:${ALPINE_VERSION}"

## build the image
#
FROM ${FROM_IMAGE}

COPY ./etc /etc

ENTRYPOINT ["/init"]
