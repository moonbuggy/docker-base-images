#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/scratch}"

all_tags='none'
default_tag='none'

. "hooks/.build.sh"
