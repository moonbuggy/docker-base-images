#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6-lighttpd}"
SOURCE_REPO='moonbuggy2000/debian-slim-s6'

all_tags='latest'
default_tag='latest'

TARGET_VERSION_TYPE='custom'

## get the latest package version from the APT repo
#
custom_source_latest() {
	case ${1} in
		1.4.53*)	deb_release='buster'	;;
		1.4.59*)	deb_release='bullseye'	;;
		11.4.69*)	deb_release='bookworm'	;;
	esac
	echo "$(debian_package_version 'lighttpd' "${deb_release}" | cut -d'-' -f1,2)"
}

custom_repo_latest()	{
	echo "${REPO_TAGS}" | xargs -n1 | grep -Po "(^${1}\.[\.0-9]*)(-[\.0-9]*)(?=-)" | sort -uV | tail -n1
}

. "hooks/.build.sh"
