#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
##[ -z "${DO_PUSH+set}" ] && NO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6}"

all_tags='3.5 3.6 3.7 3.8 3.9 3.10 3.11 3.12 3.13 3.14 3.15'
default_tag='latest'

. "hooks/.build.sh"
