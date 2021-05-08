#! /bin/bash

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-nginx}"

all_tags='1.12 1.14 1.16 1.18'
default_tag='latest'

. "hooks/.build.sh"
