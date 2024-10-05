#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-pypy}"

all_tags='2.7 3.6'
default_tag='3.6'

. "hooks/.build.sh"
