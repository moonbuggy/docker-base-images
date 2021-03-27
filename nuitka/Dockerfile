ARG ALPINE_VERSION="3.13.2"
ARG PYTHON_VERSION="3.8"
ARG NUITKA_VERSION="0.6.12"

#ARG FROM_IMAGE="python:${PYTHON_VERSION}-alpine"
ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"

## build the image
#
FROM "${FROM_IMAGE}"

ARG PYTHON_VERSION

RUN apk -U add --no-cache \
		cargo \
		ccache \
		chrpath \
		gcc \
		libffi-dev \
		make \
		musl-dev \
		openssl-dev \
		py3-pip \
		py3-wheel \
		python3=~"${PYTHON_VERSION}" \
		python3-dev=~"${PYTHON_VERSION}" \
		rust \
		subversion

ARG NUITKA_VERSION
ENV LIBSODIUM_MAKE_ARGS="-j4"

#	pip3 install --no-cache-dir --upgrade pip \
RUN python3 -m pip install --no-cache-dir --upgrade pip \
	&& pip3 install --no-cache-dir nuitka=="${NUITKA_VERSION}"

ENTRYPOINT ["python3","-m","nuitka"]