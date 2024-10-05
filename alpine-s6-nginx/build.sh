#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-nginx}"

default_tag='latest'

TARGET_VERSION_TYPE='custom'

custom_versions () {
  echo "${REPO_TAGS}" | xargs -n1 | grep -oP '(^\d+\.\d+)' | sort -uV
}

custom_repo_latest () {
  echo "${REPO_TAGS}" | xargs -n1 | grep -oP "(^[\d\.]*)(?=-alpine${1})" | sort -uV
}

custom_source_latest () {
  alpine_package_version 'nginx' "$(get_alpine_version ${1})"
}

. "hooks/.build.sh"
