#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/nuitka}"

python_versions='3.8 3.9 3.10 3.11 3.12'

all_alpine=""
all_debian=""
for python_version in $python_versions; do
    all_alpine="${python_version}-alpine ${all_alpine}"
    all_debian="${python_version}-debian ${all_debian}"
done

all_tags="${all_alpine} ${all_debian}"
default_tag='latest'

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
