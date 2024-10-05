#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-nginx-php-fpm}"

# all_tags='5.6 7.2 7.3 7.4 8.0 8.1 8.2 8.3'
default_tag='latest'

TARGET_VERSION_TYPE='custom'

custom_source_latest () {
  alpine_package_version "php$(get_package_ver_string ${1})-fpm" "$(get_alpine_version ${1})"
}

. "hooks/.build.sh"
