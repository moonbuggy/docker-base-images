#! /bin/bash

NOOP='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-pypy}"
DOCKER_TAG="${1:-3.6}"
IMAGE_NAME="${DOCKER_REPO}:${DOCKER_TAG}"

. "../.common/build.sh"
