#! /bin/bash
# shellcheck disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6-nginx-php-fpm}"
SOURCE_REPO='moonbuggy2000/debian-slim-s6-nginx'

all_tags='7.3 7.4 8.2'
default_tag='latest'

# Because we can't seem to pull data for the php-fpm package from Debian's repo
# API the automatic update does nothing currently. Leave this here for now though,
# in case the package version numbers become vailable through one method or
# another.

TARGET_VERSION_TYPE='minor'

custom_source_versions () {
   nginx_versions="$(echo "${@}" | xargs -n1 | grep -Eo "^[0-9]+(\.[0-9]+){2}\-[0-9]+[^\.\-]?" | grep -v "\-386$" | sort -uV | xargs)"
   for n_ver in ${nginx_versions}; do
     case "${n_ver}" in
       1.14*) printf '7.3 ' ;;
       1.18*) printf '7.4 ' ;;
       1.22*) printf '8.2 ' ;;
     esac
   done
   log_debug "package release: $(debian_package_release nginx 1.18)"
   log_debug "package version: $(debian_package_version nginx bookworm)"
}

custom_versions () {
  echo "${SOURCE_VERSIONS}"
}

. "hooks/.build.sh"
