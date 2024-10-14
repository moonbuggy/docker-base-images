#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6}"
SOURCE_REPO='alpine'

TARGET_VERSION_TYPE='minor'

. "hooks/.build.sh"
