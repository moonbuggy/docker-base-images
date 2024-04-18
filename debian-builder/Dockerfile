ARG DEBIAN_RELEASE="buster"
ARG FROM_IMAGE="debian:${DEBIAN_RELEASE}"

## build the image
#
FROM "${FROM_IMAGE}"

# QEMU static binaries from pre_build (retained in this image)
ARG QEMU_DIR
ARG QEMU_ARCH=""
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

ARG BUILD_DIR="/build"
ARG PUID="${PUID:-1000}"
ARG GUID="${GUID:-1000}"

# use a local APT caching proxy, if one is provided
ARG APT_CACHE=""
RUN if [ ! -z "${APT_CACHE}" ]; then \
		echo "Acquire::http { Proxy \"${APT_CACHE}\"; }" > /etc/apt/apt.conf.d/proxy; fi \
	&& apt-get update && apt-get install -qy --no-install-recommends \
		autoconf \
		bison \
		build-essential \
		clang \
		flex \
		git \
		sudo \
	&& rm -rf /var/lib/apt/lists/* \
	&& addgroup --system --gid "${GUID}" builder \
	&& adduser --system --uid "${PUID}" --home "${BUILD_DIR}" --ingroup builder builder \
	&& echo "builder	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
	&& (rm -f /etc/apt/apt.conf.d/proxy 2>&1 || true)

WORKDIR "${BUILD_DIR}"
#USER builder

ENTRYPOINT ["/bin/bash", "-l", "-c"]
