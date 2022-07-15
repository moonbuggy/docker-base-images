#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
##[ -z "${DO_PUSH+set}" ] && NO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/s6}"

all_tags='latest alpine3.15 alpine3.14 alpine3.13 alpine3.12 alpine3.11 alpine3.10'
default_tag='latest'

. "hooks/.build.sh"
