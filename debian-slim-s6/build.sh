#! /bin/bash
# shellcheck shell=bash disable=SC2034

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6}"

#all_tags='jessie stretch buster bullseye'
default_tag='bullseye'

TARGET_VERSION_TYPE='major'

. "hooks/.build.sh"
