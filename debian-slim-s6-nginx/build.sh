#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6-nginx}"
SOURCE_REPO='moonbuggy2000/debian-slim-s6'

all_tags='latest'
default_tag='latest'

custom_repo_latest() {
  echo "${REPO_VERSIONS}" | xargs -n1 | grep -Po "(${1}[\.\d]+)" | sort -uV | tail -n1
}

## get the latest package version from the APT repo
#
custom_source_latest() {
  case ${1} in
    1.14*)  deb_release='buster'  ;;
    1.18*)  deb_release='bullseye'  ;;
    1.22*)  deb_release='bookworm'  ;;
  esac

  echo "$(debian_package_version 'nginx' "${deb_release}" | cut -d'-' -f1)"
}

TARGET_VERSION_TYPE='custom'

. "hooks/.build.sh"
