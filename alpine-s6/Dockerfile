ARG TARGET_VERSION="3.13.4"
ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

ARG FROM_IMAGE="alpine:${TARGET_VERSION}"

## get s6 overlay
FROM "moonbuggy2000/s6:${S6_VERSION}-${S6_ARCH}" AS s6

## collect everything we need
FROM "alpine:${TARGET_VERSION}" AS builder

COPY --from=s6 /s6-root /builder-root
COPY ./root /builder-root

ARG TARGET_VERSION
RUN echo "ALPINE_VERSION=${TARGET_VERSION}"  >> /builder-root/etc/contenv_extra

## build the final image
FROM "${FROM_IMAGE}"

COPY --from=builder /builder-root/ /

ENTRYPOINT ["/init"]
