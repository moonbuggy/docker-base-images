#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'
#NO_CLEAN='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-node-nginx}"

all_tags='10 12 14 16 18'
default_tag='latest'

. "hooks/.build.sh"
