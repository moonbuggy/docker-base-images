#! /bin/bash
# shellcheck disable=SC2034

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/nuitka}"

python_versions='3.7 3.8 3.9 3.10'

all_alpine=""
all_debian=""
for python_version in $python_versions; do
    all_alpine="${python_version}-alpine ${all_alpine}"
    all_debian="${python_version}-debian ${all_debian}"
done

# all_tags='3.7-alpine 3.7-debian 3.8-alpine 3.8-debian 3.9-alpine 3.9-debian 3.10-alpine 3.10-debian'
all_tags="${all_alpine} ${all_debian}"
default_tag='latest'

. "hooks/.build.sh"
