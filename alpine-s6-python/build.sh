#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
##[ -z "${DO_PUSH+set}" ] && NO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6-python}"
SOURCE_REPO='python'

# all_tags='2.7 3.3 3.4 3.5 3.6 3.7 3.8 3.9 3.10 3.8-alpine3.14 3.9-alpine3.14 3.9-alpine3.15 3.10-alpine3.14'
default_tag='latest 3.10.3-alpine3.14'

TARGET_VERSION_TYPE='custom'
MINIMUM_VERSION='3.3'

custom_target_versions() {
  parse_version_minor "$(echo ${SOURCE_REPO_TAGS} | xargs -n1 | grep -oP '(^[\.0-9]+)(?=\-alpine.*)' | sort -uV | xargs)"
}

. "hooks/.build.sh"
