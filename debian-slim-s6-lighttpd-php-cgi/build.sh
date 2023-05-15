#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
##[ -z "${DO_PUSH+set}" ] && NO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6-lighttpd-php-cgi}"
SOURCE_REPO='moonbuggy2000/debian-slim-s6-lighttpd'

all_tags='latest'
default_tag='latest'

. "hooks/.build.sh"
