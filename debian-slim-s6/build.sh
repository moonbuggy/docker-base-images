#! /bin/bash

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6}" 
DOCKER_TAG="${1:-buster}"

. hooks/post_checkout
. hooks/pre_build
. hooks/build
. hooks/push
. hooks/post_push
