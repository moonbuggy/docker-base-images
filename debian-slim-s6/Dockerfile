ARG DEBIAN_RELEASE="buster"
ARG FROM_IMAGE="debian:${DEBIAN_RELEASE}-slim"

ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

## get s6 overlay
#
FROM "moonbuggy2000/s6:${S6_VERSION}-${S6_ARCH}" AS s6

## build the image
#
FROM "${FROM_IMAGE}"

COPY --from=s6 /s6-root/ /
COPY ./root /

ARG DEBIAN_RELEASE

RUN add-contenv DEB_RELEASE="${DEBIAN_RELEASE}"

ENTRYPOINT ["/init"]
