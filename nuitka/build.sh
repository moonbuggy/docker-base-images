#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/nuitka}"

# debian stopped building in 3.8 and 3.9 on some architectures,
# can't be bothered making exceptions in build.conf
# python_versions='3.8 3.9 3.10 3.11 3.12 3.13'
python_versions='3.10 3.11 3.12 3.13'

# this breaks because it doesn't handle the tag processing below, it's easier
# just to do './build.sh all' and make the latest version
# TARGET_VERSION_TYPE='major'
#
# custom_source_versions() {
#   echo "$(git_repo_tags 'nuitka/nuitka')"
# }
#
# custom_target_versions() {
#   echo ${REPO_TAGS} | xargs -n1 | grep -oE '([0-9]*\.){2}[0-9\.]*(?=-py)*' | sort -uV
# }

all_alpine=""
all_debian=""
for python_version in $python_versions; do
    all_alpine="${python_version}-alpine ${all_alpine}"
    all_debian="${python_version}-debian ${all_debian}"
done

all_tags="${all_alpine} ${all_debian}"
default_tag='latest'

# build for all specified python verisons by default
tags=''
for tag in "${@}"; do
  [ "x${tag}" = "x${tag//pyall/}" ] \
    && tags="${tag} ${tags}" \
    && continue

  for ver in $python_versions; do
    tags="${tag%%pyall*}py${ver}${tag##*-pyall} ${tags}"
  done
done

. hooks/.build.sh ${tags}
