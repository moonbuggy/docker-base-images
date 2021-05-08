#! /bin/bash

#NOOP='true'
#DO_PUSH='true'
##[ -z "${DO_PUSH+set}" ] && NO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/s6}"

all_tags='latest'
default_tag='latest'

. "hooks/.build.sh"