#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'
#NO_CLEAN='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-nginx}"

all_tags='alpine3.8 alpine3.12 1.12 1.14 1.16 1.18 1.20'
default_tag='latest'

. "hooks/.build.sh"
