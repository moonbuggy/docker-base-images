#ARG ALPINE_VERSION="3.13"
ARG BUILD_PYTHON_VERSION="3.9"
ARG NUITKA_VERSION="0.6.16.4"

ARG FROM_IMAGE="python:${BUILD_PYTHON_VERSION}-alpine"
#ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"

## build the image
#
FROM "${FROM_IMAGE}"

# QEMU static binaries from pre_build
ARG QEMU_DIR=""
ARG QEMU_ARCH=""
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

ARG BUILD_PYTHON_VERSION

RUN apk add --no-cache \
		cargo \
		ccache \
		chrpath \
		gcc \
		libffi-dev \
		make \
		musl-dev \
		openssl-dev \
		patchelf \
#		py3-pip \
#		py3-wheel \
#		python3=~"${BUILD_PYTHON_VERSION}" \
#		python3-dev=~"${BUILD_PYTHON_VERSION}" \
		rust \
		subversion

# version check in case we accidentally upgraded Python along the way
RUN _pyver="$(python --version | sed -En 's|Python\s+([0-9.]*)|\1|p' | awk -F \. '{print $1"."$2}')" \
	&& if [ "x${_pyver}" != "x${BUILD_PYTHON_VERSION}" ]; then \
		echo "ERROR: Python reports version ${_pyver}, doesn't match build version ${BUILD_PYTHON_VERSION}"; \
		echo "Exiting"; exit 1; fi

ARG BUILDER_ROOT="/builder-root"
WORKDIR "${BUILDER_ROOT}"

ENV	VIRTUAL_ENV="${BUILDER_ROOT}/venv" \
		PYTHONUNBUFFERED="1" \
		PYTHONDONTWRITEBYTECODE="1" \
		MAKEFLAGS="-j$(nproc)"

RUN python -m pip install --upgrade virtualenv

RUN python -m virtualenv --download "${VIRTUAL_ENV}"

# Python wheels from pre_build
ARG IMPORTS_DIR=".imports"
ARG TARGET_ARCH_TAG=""
COPY _dummyfile "${IMPORTS_DIR}/${TARGET_ARCH_TAG}*" "/${IMPORTS_DIR}/"

# activate virtual env
ENV PATH="${VIRTUAL_ENV}/bin:$PATH"

ARG NUITKA_VERSION=""
ENV LIBSODIUM_MAKE_ARGS="-j4"

RUN python3 -m pip install --no-cache-dir --upgrade pip \
	&& pip3 install --no-cache-dir --find-links "/${IMPORTS_DIR}/" nuitka=="${NUITKA_VERSION}"

# cleanup, if we're squashing
RUN rm -rf "/${IMPORTS_DIR}/"

ENTRYPOINT ["python3","-m","nuitka"]

# in this case retain the QEMU start binaries
