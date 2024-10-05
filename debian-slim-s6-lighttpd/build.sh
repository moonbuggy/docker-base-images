#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6-lighttpd}"
SOURCE_REPO='moonbuggy2000/debian-slim-s6'

default_tag='latest'

TARGET_VERSION_TYPE='custom'

## get the latest package version from the APT repo
#
custom_target_versions () {
	echo "${REPO_VERSIONS}" | xargs -n1 | grep -oE "^[0-9]*(\.[0-9]*){2}" | sort -uV
}

custom_source_latest () {
	debian_package_version 'lighttpd' "$(debian_package_release 'lighttpd' "${1}")" | cut -d'-' -f1,2
}

custom_repo_latest () {
	echo "${REPO_TAGS}" | xargs -n1 | grep -Po "^${1}(-[\.0-9]+)(?=-)" | sort -uV | tail -n1
}

. "hooks/.build.sh"
