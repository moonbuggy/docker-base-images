#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
##[ -z "${DO_PUSH+set}" ] && NO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6}"

#all_tags='3.7 3.7.3 3.8 3.8.5 3.9 3.9.6 3.10 3.10.5 3.10.6 3.10.7 3.10.9 3.11 3.11.6 3.11.8 3.11.9 3.11.10 3.11.11 3.12 3.12.3 3.12.4 3.12.5 3.12.7 3.13 3.13.2 3.13.3 3.13.4 3.13.5 3.14.0'
all_tags='3.5 3.6 3.7 3.8 3.9 3.10 3.11 3.12 3.13 3.14 latest'
default_tag='latest'

. "hooks/.build.sh"
