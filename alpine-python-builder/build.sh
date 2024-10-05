#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-python-builder}"

all_tags='3.8 3.9 3.10 3.11 3.12'
default_tag="${all_tags}"

TARGET_VERSION_TYPE='minor'

custom_source_versions () {
  echo "${@}" | xargs -n1 | grep -oP '(^[\.0-9]+)(?=\-alpine.*)' | sort -uV
}

. "hooks/.build.sh"
