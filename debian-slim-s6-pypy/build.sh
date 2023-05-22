#! /bin/bash
# shellcheck shell=bash disable=SC2034

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6-pypy}"

all_tags='2.7 3.5 3.6 3.7 3.8 3.9'
default_tag='3.9'

. "hooks/.build.sh"
