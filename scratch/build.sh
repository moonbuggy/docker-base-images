#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#[ -z "${DO_PUSH+set}" ] && NO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/scratch}"

#all_tags='amd64 arm64v8 armv5 armv6 armv7 i386 ppc64le s390x'
#default_tag='amd64 arm64v8 armv5 armv6 armv7 i386 ppc64le s390x'
all_tags='none'
default_tag='none'

. "hooks/.build.sh"
