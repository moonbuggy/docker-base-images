#! /bin/bash
# shellcheck shell=bash disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6}"

#all_tags='jessie stretch buster bullseye bookworm'
default_tag='bookworm'

TARGET_VERSION_TYPE='major'

. "hooks/.build.sh"
