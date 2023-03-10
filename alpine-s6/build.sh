#! /bin/bash
# shellcheck disable=SC2034

# Enable for extra output to the shell
# DEBUG='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6}"
SOURCE_REPO='alpine'

# all_tags='3.5 3.6 3.7 3.8 3.9 3.10 3.11 3.12 3.13 3.14 3.15 3.16 3.17'

log_debug () { [ ! -z "${DEBUG}" ] && >&2 printf "$*\n"; }

get_repo_data () {
  eval_param_ifn REPO_TAGS "docker_api_repo_tags ${DOCKER_REPO}"
  repo_versions="$(echo ${REPO_TAGS} | xargs -n1 | grep -Eo "(^[0-9]*\.[\.0-9]*)" | sort -uV)"

  eval_param_ifn SOURCE_REPO_TAGS "docker_api_repo_tags ${SOURCE_REPO}"
  source_versions="$(echo ${SOURCE_REPO_TAGS} | xargs -n1 | grep -Eo '(^[0-9]*\.[\.0-9]*)' | sort -uV)"
}

get_target_versions () {
  source_minor_versions="$(echo ${source_versions} | xargs -n1 | grep -Eo "(^[0-9]*\.[0-9]*)" | sort -uV | xargs)"
  log_debug "Source versions: ${source_minor_versions}"

  # don't build anything older than what's already in the target repo
  min_ver="$(parse_version_minor "$(echo ${repo_versions} | xargs -n1 | tail -n +1 | head -n1)")"
  log_debug "Target minimum: ${min_ver}"

  target_versions="${min_ver} ${source_minor_versions##*${min_ver} }"
  log_debug "Target versions: ${target_versions}\n"

  echo "${target_versions}"
}

check_updates () {
  >&2 printf "Checking if we're up to date..\n"

  log_debug "Source versions:\n$(echo ${source_versions} | xargs)\n"
  log_debug "Repo versions:\n$(echo ${repo_versions} | xargs)\n"

  updateable=''
  for alpine_minor in ${1}; do
    repo_latest="$(echo "${repo_versions}" | grep -Po "^${alpine_minor//./\\.}(\.[0-9]*|$)" | sort -uV | tail -n1)"
    source_latest="$(echo "${source_versions}" | grep -Po "^${alpine_minor//./\\.}(\.[0-9]*|$)" | sort -uV | tail -n1)"

    if [ "$(printf '%s\n' "${source_latest}" "${repo_latest}" | sort -V | tail -n1)" != "${repo_latest}" ]; then
      >&2 printf "%-10s %10s -> %s\n" "${alpine_minor}" "${repo_latest}" "${source_latest}"
      updateable="${alpine_minor} $updateable"
    else
      >&2 printf "%-10s %10s matched\n" "${alpine_minor}" "${repo_latest}"
    fi
  done
  >&2 printf "\n"

  echo "${updateable}"
}

# default to 'update' build
first_arg="${1:-update}"

# check if we're doing a special build
#
case "${first_arg}" in
  check|update*|all)
    # we can use the string parsing and data collection from the Docker build hooks
    # DOCKER_TAG here just sets the filename for the config.yaml
    DOCKER_TAG='update'
    . "hooks/env"

    get_repo_data
    all_tags="$(get_target_versions)"
    ;;&
  all)
    build_tags="${all_tags}"
    ;;
  check|update*)
    updateable="$(check_updates "${all_tags}")"
    ;;&
  check)
    printf 'Updateable: %s\n\n' "${updateable[*]}"
    exit
    ;;
  update*)
    build_tags="${updateable}"
    ;;
  *)
    build_tags="${*}"
    ;;
esac

printf 'Building: %s\n\n' "${build_tags}"
. "hooks/.build.sh" "${build_tags}"
