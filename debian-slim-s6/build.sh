#! /bin/bash
# shellcheck shell=bash disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6}"

default_tag='bookworm'

# a lot of architectures disappeared from the images, so there's older versions
# that are more broadly compaitble
most_arch_support='8.10 9.12 10.11 11.10 12.7'

# an 'all' build will find the latest verions
TARGET_VERSION_TYPE='major'

# a 'best' built will go with the most architecture compatible versions
[ "${1}" = 'best' ] \
  && set -- ${most_arch_support}

case "${1}" in
  best) set -- ${most_arch_support} ;;
  all|update|latest)
    echo "Are you sure you don't want to want to do a 'best' build? Latest versions will have much more limited architecture support."
    printf "%s " "Press enter to continue"
    read ans  ;;
esac

. "hooks/.build.sh"
