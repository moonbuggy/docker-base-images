#! /bin/bash
# shellcheck shell=bash disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6-python}"

default_tag='latest'

TARGET_VERSION_TYPE='minor'

# version 3.2 doesn't build
MINIMUM_VERSION='3.3'

custom_source_versions () {
  echo "${@}" | xargs -n1 | grep '\.' | sed -En 's|^([0-9\.]+)-slim.*|\1|p' | sort -uV
}

. "hooks/.build.sh"
