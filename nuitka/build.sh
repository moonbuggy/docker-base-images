#! /bin/bash

#NOOP='true'
NOPUSH='true'
#NOBUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/nuitka}"
DOCKER_TAG="${1:-latest}"
IMAGE_NAME="${DOCKER_REPO}:${DOCKER_TAG}"

. "../.common/build.sh"
