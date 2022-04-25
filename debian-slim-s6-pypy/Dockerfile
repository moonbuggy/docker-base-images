# syntax=docker/dockerfile:1.3-labs

ARG DEBIAN_VERSION="10.11"
ARG FROM_IMAGE="moonbuggy2000/debian-slim-s6:${DEBIAN_VERSION}"

ARG TARGET_ARCH_TAG="amd64"
ARG PYPY_PACKAGE="pypy3"

ARG FETCHER_ARCH="amd64"
ARG FETCHER_ROOT="/fetcher-root"

ARG PYTHON_VERSION="3.8"
ARG PYPY_VERSION="7.3.7"
ARG PYPY_DIR="/pypy-${PYPY_VERSION}"

## get pypy and prepare files
#
FROM "moonbuggy2000/fetcher:latest" AS fetcher

ARG FETCHER_ROOT
ARG PYPY_DIR
WORKDIR "${FETCHER_ROOT}${PYPY_DIR}"

ARG TARGET_ARCH_TAG
ARG PYTHON_VERSION
ARG PYPY_VERSION
RUN case "${TARGET_ARCH_TAG}" in \
		386) PYPY_ARCH='linux32' ;; \
		arm64*) PYPY_ARCH='aarch64' ;; \
		amd64) PYPY_ARCH='linux64' ;; \
		*) PYPY_ARCH="${TARGET_ARCH_TAG}" ;; \
	esac \
	&& PYPY_TARBALL="https://downloads.python.org/pypy/pypy${PYTHON_VERSION}-v${PYPY_VERSION}-${PYPY_ARCH}.tar.bz2" \
	&& echo "*** PYPY_TARBALL: ${PYPY_TARBALL}" \
	&& wget -qO- "${PYPY_TARBALL}" | tar -xj --strip-components 1

# links to the executable
WORKDIR "${FETCHER_ROOT}/usr/local/bin"

ARG PYPY_PACKAGE
RUN ln -sf "../../..${PYPY_DIR}/bin/${PYPY_PACKAGE}" "./${PYPY_PACKAGE}" \
	&& ln -sf "../../..${PYPY_DIR}/bin/${PYPY_PACKAGE}" ./python \
	&& [ "${PYTHON_VERSION%\.*}" != '3' ] \
		|| { ln -sf "../../..${PYPY_DIR}/bin/${PYPY_PACKAGE}" ./python3; \
			ln -sf "../../..${PYPY_DIR}/bin/${PYPY_PACKAGE}" ./pypy; }


## build the image
#
FROM "${FROM_IMAGE}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR
ARG QEMU_ARCH
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

RUN apt-get update && apt-get install -qy --no-install-recommends \
		libexpat1 \
		libtinfo5 \
	&& rm -rf /var/lib/apt/lists/*

ARG FETCHER_ROOT
COPY --from=fetcher "${FETCHER_ROOT}/" /

RUN rm -f "/usr/bin/qemu-${QEMU_ARCH}-static" >/dev/null 2>&1

## drop QEMU static binaries
#
FROM "moonbuggy2000/scratch:${TARGET_ARCH_TAG}"

COPY --from=builder / /

ARG PYPY_DIR
ENV PATH="${PYPY_DIR}/bin:${PATH}"

ENTRYPOINT ["/init"]
