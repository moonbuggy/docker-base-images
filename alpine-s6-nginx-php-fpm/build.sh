#! /bin/bash

#NOOP='true'
#DO_PUSH='true'
##[ -z "${DO_PUSH+set}" ] && NO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-nginx-php-fpm}"

all_tags='5.6 7.3 7.4 8.0'
default_tag='latest'

. "hooks/.build.sh"
