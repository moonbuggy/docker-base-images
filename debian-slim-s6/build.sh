#! /bin/bash

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6}"

all_tags='jessie stretch buster bullseye'
default_tag='buster'

. "hooks/.build.sh"
