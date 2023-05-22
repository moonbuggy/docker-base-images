#! /bin/bash
# shellcheck shell=bash disable=SC2034

#NOOP='true'
#DO_PUSH='true'
##[ -z "${DO_PUSH+set}" ] && NO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6-python}"

all_tags='2.7 3.3 3.4 3.5 3.6 3.7 3.8 3.9 3.10'
default_tag='latest'

# version 3.2 doesn't build
MINIMUM_VERSION='3.3'

# TARGET_VERSION_TYPE='minor'

# version 3.12 doesn't build
TARGET_VERSION_TYPE='custom'
custom_versions () {
  echo "$(parse_version_minor "$(echo ${SOURCE_MINOR_VERSIONS} | xargs -n1 | grep -vP '^3\.12.*' | xargs)")"
}

. "hooks/.build.sh"
