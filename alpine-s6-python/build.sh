#! /bin/bash

#NOOP='true'
#DO_PUSH='true'
##[ -z "${DO_PUSH+set}" ] && NO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-python}"

all_tags='2.7 3.3 3.4 3.5 3.6 3.7 3.8 3.9'
default_tag='latest'

. "hooks/.build.sh"