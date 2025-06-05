#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6-nginx}"
SOURCE_REPO='moonbuggy2000/debian-slim-s6'

all_tags='latest'
default_tag='latest'

TARGET_VERSION_TYPE='custom'

## get the latest package version from the APT repo
#
custom_source_latest() {
  debian_package_version 'nginx' "$(debian_package_release 'nginx' "${1}")" | cut -d'-' -f1,2
}

custom_source_versions() {
  output=''
  for version in $(parse_version_major "${@}"); do
    output="$output$(debian_package_version 'nginx' ${debian_names[${version}]}) "
  done
  echo "$output"
}

custom_target_versions() {
  custom_vers="$(echo ${REPO_TAGS} | xargs -n1 | grep -oE "^[0-9]*(\.[0-9]*){2}\-[0-9\.]*" | sort -uV)"

  # versions are in the format: X.Y.Z(-Q(.R))
  # the above regex returns both X.Y.Z-Q and X.Y.Z-Q.R if both exist,
  # and it's easiest to remove the X.Y.Z-Q from the list in a loop
  for version in $custom_vers; do
    custom_vers=$(echo "${custom_vers}" | grep -v ${version%.*}'$' | xargs -n1)
  done
  echo $custom_vers
}

custom_repo_latest()  {
  echo ${REPO_TAGS} | xargs -n1 | grep -Po "(^${1}\.[\.0-9]*)(-[\.0-9]*)(?=-)" | sort -uV | tail -n1
}

. "hooks/.build.sh"
