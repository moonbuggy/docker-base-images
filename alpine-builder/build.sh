#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-builder}"

all_tags='latest'
default_tag='latest'

. "hooks/.build.sh"
