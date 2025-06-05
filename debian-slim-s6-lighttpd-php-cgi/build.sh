#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6-lighttpd-php-cgi}"
SOURCE_REPO='moonbuggy2000/debian-slim-s6-lighttpd'

all_tags='7.4 8.2 8.3 8.4'
default_tag='latest'

. "hooks/.build.sh"
