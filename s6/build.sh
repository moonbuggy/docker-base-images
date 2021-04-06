#! /bin/bash

#NOOP='true'
NOPUSH='true'
#NOBUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/s6}"
DOCKER_TAG="${1:-latest}"
# shellcheck disable=SC2034
IMAGE_NAME="${DOCKER_REPO}:${DOCKER_TAG}"

. "../.common/build.sh"
