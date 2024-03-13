#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-python-builder}"

all_tags='3.8 3.9 3.10 3.11 3.12'
default_tag="${all_tags}"

. "hooks/.build.sh"
