#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/nuitka}"

all_tags='3.7-alpine 3.7-debian 3.8-alpine 3.8-debian 3.9-alpine 3.9-debian'
default_tag='latest'

. "hooks/.build.sh"
