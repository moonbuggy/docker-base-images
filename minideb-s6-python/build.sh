#! /bin/bash

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/minideb-s6-python}"

all_tags='2.7-jessie 2.7-stretch 2.7-buster 3.4-jessie 3.5-stretch 3.7-buster'
default_tag='3.7-buster'

. "hooks/.build.sh"
