ARG NGINX_VERSION="1.18"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6-nginx:${NGINX_VERSION}"

## build the image
#
FROM "${FROM_IMAGE}"

COPY ./etc /etc

ENTRYPOINT ["/init"]
