ARG DEBIAN_RELEASE="buster"
ARG FROM_IMAGE="moonbuggy2000/debian-slim-s6:${DEBIAN_RELEASE}"

## build the image
#
FROM ${FROM_IMAGE}

ARG PYTHON_VERSION="3.7.3-1"

RUN case ${PYTHON_VERSION} in 2*) PYTHON_PACKAGE=python;; *) PYTHON_PACKAGE=python3;; esac \
	&& add-contenv \
		PYTHON_VERSION=${PYTHON_VERSION} \
		PYTHON_PACKAGE=${PYTHON_PACKAGE} \
	&& apt-get update \
	&& apt-get install -qy --no-install-recommends $PYTHON_PACKAGE=${PYTHON_VERSION} ${PYTHON_PACKAGE}-pip \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/init"]
