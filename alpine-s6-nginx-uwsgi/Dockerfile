# syntax = docker/dockerfile:1.4.0

ARG NGINX_VERSION="1.22"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6-nginx:${NGINX_VERSION}"

## build the image
#
FROM "${FROM_IMAGE}"

COPY root/ /

ENTRYPOINT ["/init"]
