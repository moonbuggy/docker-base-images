#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/s6-add-contenv}"

all_tags='2 3 both'
default_tag='all'

. "hooks/.build.sh"
