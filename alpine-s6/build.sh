#! /bin/bash

NOOP='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6}"
DOCKER_TAG="${1:-3.13.2}"
# shellcheck disable=SC2034
IMAGE_NAME="${DOCKER_REPO}:${DOCKER_TAG}"

. "../.common/build.sh"
