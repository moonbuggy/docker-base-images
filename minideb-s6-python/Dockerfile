ARG MINIDEB_RELEASE="buster"
ARG FROM_IMAGE="moonbuggy2000/minideb-s6:${MINIDEB_RELEASE}"

ARG S6_VERSION="latest"
ARG S6_ARCH="amd64"

ARG TARGET_ARCH_TAG="amd64"

## get s6 overlay
FROM "moonbuggy2000/s6:${S6_VERSION}-${S6_ARCH}" AS s6

## build the image
#
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR
ARG QEMU_ARCH
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

COPY --from=s6 / /

ARG PYTHON_VERSION="3.7.3-1"
ARG MINIDEB_RELEASE

RUN case "${PYTHON_VERSION}" in 2*) PYTHON_PACKAGE=python;; *) PYTHON_PACKAGE=python3;; esac \
	&& add-contenv \
		PYTHON_VERSION="${PYTHON_VERSION}" \
		PYTHON_PACKAGE="${PYTHON_PACKAGE}" \
	&& apt-get update \
	&& apt-get install -qy --no-install-recommends "${PYTHON_PACKAGE}=${PYTHON_VERSION}" "${PYTHON_PACKAGE}-pip" \
	&& rm -rf /var/lib/apt/lists/*

RUN rm -f "/usr/bin/qemu-${QEMU_ARCH}-static" >/dev/null 2>&1

## build the final image
FROM "moonbuggy2000/scratch:${TARGET_ARCH_TAG}"

COPY --from=builder / /

ENTRYPOINT ["/init"]
