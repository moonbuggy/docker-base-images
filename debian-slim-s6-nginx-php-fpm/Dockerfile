# syntax = docker/dockerfile:1.4.0

ARG NGINX_VERSION="1.18"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6-nginx:${NGINX_VERSION}"

ARG PHP_VERSION="7.4"
ARG PHP_BINARY="php-fpm${PHP_VERSION}"


## prepare config files
#
ARG BUILDPLATFORM="linux/amd64"
FROM --platform="${BUILDPLATFORM}" "${FROM_IMAGE}" AS config

WORKDIR /config_root
COPY root/ ./

RUN chmod a+x healthcheck.sh

WORKDIR /config_root/etc

ARG PHP_VERSION
# remove unecessary php configs and rename folder for minor version
RUN rm -rvf $(ls -d php/* | grep -v ".*${PHP_VERSION%.*}\$" | xargs) \
  && mv "php/${PHP_VERSION%.*}" "php/${PHP_VERSION}"

# configure environment
ARG PHP_BINARY
RUN add-contenv \
		PHP_VERSION=${PHP_VERSION} \
		PHP_BINARY=${PHP_BINARY} \
	&& cp /etc/contenv_extra ./


## build the image
#
FROM "${FROM_IMAGE}"

# install PHP-FPM
# using the package name with the version included (i.e. 'php<ver>-fpm', not
# 'php-fpm') acts as a sanity check. since we're menually specifying the version
# in 'build.conf' we'll get a mismatch at some future point when the available
# version changes.
ARG PHP_VERSION

# use a local APT caching proxy, if one is provided
ARG APT_CACHE=""

RUN export DEBIAN_FRONTEND="noninteractive" \
  && ([ ! -z "${APT_CACHE}" ] \
    && echo "Acquire::http { Proxy \"${APT_CACHE}\"; }" >/etc/apt/apt.conf.d/proxy) \
  && apt update \
  && apt-get install -qy --no-install-recommends \
    "php${PHP_VERSION}-fpm" \
  && apt-get clean \
  && (rm -f /etc/apt/apt.conf.d/proxy >/dev/null 2>&1 || true)

COPY --from=config /config_root/ /

ARG NGINX_PORT="8080"
EXPOSE "${NGINX_PORT}"

ENTRYPOINT ["/init"]
