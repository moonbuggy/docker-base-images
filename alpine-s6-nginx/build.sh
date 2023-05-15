#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'
#NO_CLEAN='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-nginx}"

# all_tags='alpine3.8 alpine3.12 1.12 1.14 1.16 1.18 1.20 1.22'
default_tag='latest'

TARGET_VERSION_TYPE='custom'

custom_versions () {
  echo "${REPO_TAGS}" | xargs -n1 | grep -oP '(^\d+\.\d+)' | sort -uV
}

custom_target_versions () {
  echo "${REPO_TAGS}" | xargs -n1 | grep -oP 'alpine\K([\d\.]*)' | sort -uV
}

custom_repo_latest () {
  echo "${REPO_TAGS}" | xargs -n1 | grep -oP "(^[\d\.]*)(?=-alpine${1})" | sort -uV
}

custom_source_latest () {
  alpine_package_version 'nginx' "$(get_alpine_version ${1})"
}

. "hooks/.build.sh"
