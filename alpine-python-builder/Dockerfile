# syntax = docker/dockerfile:1.4.0

ARG PYTHON_VERSION="3.8"
ARG ALPINE_VERSION="3.18"
ARG FROM_IMAGE="python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}"

## build the wheel
#
FROM "${FROM_IMAGE}"

# use a local APK caching proxy, if one is provided
ARG APK_PROXY=""

RUN if [ ! -z "${APK_PROXY}" ]; then \
    alpine_minor_ver="$(grep -o 'VERSION_ID.*' /etc/os-release | grep -oE '([0-9]+\.[0-9]+)')"; \
    mv /etc/apk/repositories /etc/apk/repositories.bak; \
    echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/main" >/etc/apk/repositories; \
    echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/community" >>/etc/apk/repositories; \
	fi

RUN apk -U add \
	ccache \
	gcc \
	git \
	libffi-dev \
	make \
	musl-dev \
	musl-utils \
	patchelf

# split rust, cargo and their dependencies into their own layers,
# to make each layer smaller and easier to push
RUN apk add libxml2 llvm16-libs
RUN apk add	rust
RUN apk add cargo

# version check in case we accidentally upgraded Python along the way
ARG PYTHON_VERSION
RUN _pyver="$(python --version 2>&1 | sed -En 's|Python\s+([0-9.]*)|\1|p')" \
	&& if [ "x${_pyver}" != "x${PYTHON_VERSION}" ]; then \
		echo "ERROR: Python reports version ${_pyver}, doesn't match build version ${PYTHON_VERSION}"; \
		echo "Exiting"; exit 1; fi

ARG BUILDER_ROOT="/builder-root"
WORKDIR "${BUILDER_ROOT}"

# CARGO_NET_GIT_FETCH_WITH_CLI overcomes an 'Unable to update registry
#	`crates-io`' error that appears in some builds for some architectures
ENV	VIRTUAL_ENV="${BUILDER_ROOT}/venv" \
		PYTHONUNBUFFERED="1" \
		PYTHONDONTWRITEBYTECODE="1" \
		MAKEFLAGS="-j$(nproc)" \
		CARGO_NET_GIT_FETCH_WITH_CLI="true"

# if we set the index via /etc/pip.conf it should work for 'virtualenv --download'
# as well, since it uses pip for the downloading but won't take '--index-url' as
# an argument
ARG PYPI_INDEX="https://pypi.org/simple"
RUN printf '%s\n' '[global]' "  index-url = ${PYPI_INDEX}" \
	"  trusted-host = $(echo "${PYPI_INDEX}" | cut -d'/' -f3 | cut -d':' -f1)" \
	> /etc/pip.conf

# install virtual env
RUN python -m pip install --upgrade virtualenv
RUN python -m virtualenv --download "${VIRTUAL_ENV}"

# activate virtual env
ENV PATH="${VIRTUAL_ENV}/bin:$PATH"

RUN python -m pip install --upgrade pip

RUN python -m pip install auditwheel

# remove the PyPi index and APK proxy, if they've been added
RUN (rm -f /etc/pip.conf >/dev/null 2>&1 || true) \
	&& (mv -f /etc/apk/repositories.bak /etc/apk/repositories >/dev/null 2>&1 || true)

CMD ["/bin/ash"]
