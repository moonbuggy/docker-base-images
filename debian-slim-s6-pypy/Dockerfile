# syntax = docker/dockerfile:1.4.0

ARG DEBIAN_VERSION="12.7"
ARG FROM_IMAGE="moonbuggy2000/debian-slim-s6:${DEBIAN_VERSION}"

ARG TARGET_ARCH_TAG="amd64"
ARG PYPY_PACKAGE="pypy3"

ARG PYTHON_VERSION="3.10"
ARG PYPY_VERSION="7.3.16"
ARG PYPY_DIR="pypy-${PYPY_VERSION}"

## get pypy and prepare files
#
ARG BUILDPLATFORM="linux/amd64"
FROM --platform="${BUILDPLATFORM}" "moonbuggy2000/fetcher:latest" AS fetcher

ARG PYPY_DIR
WORKDIR "/fetcher-root/${PYPY_DIR}"

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
	&& wget -qO- "${PYPY_TARBALL}" | tar -xjf - --strip-components 1

# links to the executable
WORKDIR "/fetcher-root/usr/local/bin"

ARG PYPY_PACKAGE
RUN ln -sf "../../../${PYPY_DIR}/bin/${PYPY_PACKAGE}" "./${PYPY_PACKAGE}" \
	&& ln -sf "../../../${PYPY_DIR}/bin/${PYPY_PACKAGE}" ./python \
	&& [ "${PYTHON_VERSION%\.*}" != '3' ] \
		|| { ln -sf "../../../${PYPY_DIR}/bin/${PYPY_PACKAGE}" ./python3; \
			ln -sf "../../../${PYPY_DIR}/bin/${PYPY_PACKAGE}" ./pypy; }


## build the image
#
FROM "${FROM_IMAGE}"

# use a local APT caching proxy, if one is provided
ARG APT_CACHE=""
ARG DEBIAN_FRONTEND=noninteractive
RUN ([ ! -z "${APT_CACHE}" ] \
    && echo "Acquire::http { Proxy \"${APT_CACHE}\"; }" >/etc/apt/apt.conf.d/proxy) \
	&& apt update \
	&& apt-get install -qy --no-install-recommends \
		libexpat1 \
		libtinfo5 \
	&& apt-get clean \
	&& (rm -f /etc/apt/apt.conf.d/proxy >/dev/null 2>&1 || true)

COPY --from=fetcher /fetcher-root/ /

ARG PYPY_DIR
ENV PATH="/${PYPY_DIR}/bin:${PATH}"

ENTRYPOINT ["/init"]
