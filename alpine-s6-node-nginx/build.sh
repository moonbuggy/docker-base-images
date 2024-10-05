#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-node-nginx}"

# all_tags='10 12 14 16 18'
default_tag='latest'

TARGET_VERSION_TYPE='major'

. "hooks/.build.sh"
