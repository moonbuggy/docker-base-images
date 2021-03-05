#! /bin/bash

NOOP='true'

DOCKER_REPO="${DOCKER_REPO:-pypy}"
DOCKER_TAG="${1:-slim-buster}"
IMAGE_NAME="${DOCKER_REPO}:${DOCKER_TAG}"

. "../.common/build.sh"
