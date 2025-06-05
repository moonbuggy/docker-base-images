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
  nginx_versions="$(echo "${@}" | xargs -n1 | \
    grep -Eo "^[0-9]+(\.[0-9]+){2}\-[0-9]+[^\.\-]?" | grep -v "\-386$" | sort -uV | xargs)"
  for n_ver in ${nginx_versions}; do
    debian_release="$(debian_package_release nginx ${n_ver})"

    # We can't use debian_package_version() because php-fpm doesn't seem to be
    # in the API. Pull the HTML web page for php-fpm instead
    php_version="$(get_url "https://packages.debian.org/${debian_release}/php-fpm" \
         | grep -oP '<h1>Package: php-fpm \(.*:\K[0-9\.]*')"
    log_debug "ver: ${n_ver}, debian release: ${debian_release}, php version: ${php_version}"
    printf '%s ' "${php_version}"
  done
}

custom_target_versions () {
  echo ${REPO_TAGS} | xargs -n1 | grep -oE "^[0-9]*\.[0-9]*" | sort -uV
}

. "hooks/.build.sh"
