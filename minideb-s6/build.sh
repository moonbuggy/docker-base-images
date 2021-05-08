#! /bin/bash

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/minideb-s6}"

all_tags='buster jessie stretch'
default_tag='latest'

. "hooks/.build.sh"
