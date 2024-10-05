ARG ALPINE_VERSION="3.18"
ARG BUILD_PYTHON_VERSION="3.9"
ARG NUITKA_VERSION="2.1.2"

ARG FROM_IMAGE="python:${BUILD_PYTHON_VERSION}-alpine${ALPINE_VERSION}"

## build the image
#
FROM --platform="${TARGETPLATFORM}" "${FROM_IMAGE}"

ARG BUILD_PYTHON_VERSION

# use a local APK caching proxy, if one is provided
ARG APK_PROXY=""

RUN if [ ! -z "${APK_PROXY}" ]; then \
    alpine_minor_ver="$(grep -o 'VERSION_ID.*' /etc/os-release | grep -oE '([0-9]+\.[0-9]+)')"; \
    mv /etc/apk/repositories /etc/apk/repositories.bak; \
    echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/main" >/etc/apk/repositories; \
    echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/community" >>/etc/apk/repositories; \
	fi

# break up the layers to make pushing easier
RUN apk add --no-cache gcc

# rust-stdlib accounts for roughly half the final image's size
# putting it in a separate layer should make pushes to Docker Hub more reliable
RUN apk add --no-cache rust-stdlib

RUN apk add --no-cache \
		cargo \
		ccache \
		chrpath \
		clang \
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

ARG PYPI_INDEX="https://pypi.org/simple"
RUN printf '%s\n' '[global]' "  index-url = ${PYPI_INDEX}" \
	"  trusted-host = $(echo "${PYPI_INDEX}" | cut -d'/' -f3 | cut -d':' -f1)" \
	> /etc/pip.conf

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
	&& python3 -m pip install --no-cache-dir --find-links "/${IMPORTS_DIR}/" \
		nuitka=="${NUITKA_VERSION}"

# cleanup, if we're squashing
RUN rm -rf "/${IMPORTS_DIR}/"

# remove the PyPi index and APK proxy, if they've been added
RUN (rm -f /etc/pip.conf >/dev/null 2>&1 || true) \
	&& (mv -f /etc/apk/repositories.bak /etc/apk/repositories >/dev/null 2>&1 || true)

ENTRYPOINT ["python3","-m","nuitka"]
