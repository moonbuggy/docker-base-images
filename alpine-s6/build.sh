#! /bin/bash
# shellcheck disable=SC2034

# Enable for extra output to the shell
# DEBUG='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/alpine-s6}"
SOURCE_REPO='alpine'

# all_tags='3.5 3.6 3.7 3.8 3.9 3.10 3.11 3.12 3.13 3.14 3.15 3.16 3.17'

TARGET_VERSION_TYPE='minor'

. "hooks/.build.sh"
