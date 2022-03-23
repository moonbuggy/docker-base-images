ARG FROM_IMAGE="moonbuggy2000/fetcher:latest"

ARG S6_VERSION="3.1.0.1"
ARG S6_ARCH="amd64"

ARG S6_URL="https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/"


## get s6 overlay scripts
#
FROM "moonbuggy2000/fetcher:latest" AS scripts

ARG S6_URL
ARG S6_SCRIPT_FILE="s6-overlay-noarch.tar.xz"

WORKDIR /s6/
RUN wget --no-check-certificate -qO- "${S6_URL}${S6_SCRIPT_FILE}" | tar xJf -


## get s6 overlay binaries
#
FROM "moonbuggy2000/fetcher:latest" AS s6

ARG S6_ARCH
ARG S6_URL
ARG S6_BINARY_FILE="s6-overlay-${S6_ARCH}.tar.xz"

WORKDIR /s6/
RUN wget --no-check-certificate -qO- "${S6_URL}${S6_BINARY_FILE}" | tar xJf -

COPY --from=scripts /s6/ /s6/


## build final image
#
FROM scratch

COPY --from=s6 /s6/ /
