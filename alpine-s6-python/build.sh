#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
##[ -z "${DO_PUSH+set}" ] && NO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-python}"

all_tags='2.7 3.3 3.4 3.5 3.6 3.7 3.8 3.9 3.10 3.8-alpine3.14 3.9-alpine3.14 3.10.3-alpine3.14'
default_tag='latest latest-alpine3.14'

. "hooks/.build.sh"
