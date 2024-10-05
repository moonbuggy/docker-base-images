#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-nginx-uwsgi}"

# all_tags='1.12 1.14 1.16 1.18 1.20 1.22 1.24'
default_tag='latest'

TARGET_VERSION_TYPE='minor'

. "hooks/.build.sh"
