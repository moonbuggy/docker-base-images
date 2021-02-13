#! /bin/bash

NOOP='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/minideb-s6}"
DOCKER_TAG="${1:-buster}"
IMAGE_NAME="${DOCKER_REPO}:${DOCKER_TAG}"

. "../.common/build.sh"
