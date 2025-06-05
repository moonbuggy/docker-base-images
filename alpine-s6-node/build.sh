#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-node}"

# all_tags='10 12 14 16 18 20 22'
default_tag='latest'

TARGET_VERSION_TYPE='major'

custom_source_versions () {
  echo "${@}" | xargs -n1 | grep -oP '[0-9.]+\-alpine[0-9.]+$' | xargs
}

custom_source_major_versions () {
  # odd numbered releases have no long term support, so build only even versions
  for ver in $(parse_version_major "${@}"); do
    (( ${ver} % 2 == 0 )) && printf "${ver} "
  done
  echo
}

. "hooks/.build.sh"
