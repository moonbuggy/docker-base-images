#! /bin/bash
# shellcheck shell=bash disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/debian-slim-s6-pypy}"

all_tags='2.7 3.5 3.6 3.7 3.8 3.9 3.10 3.11'
default_tag='latest'

. "hooks/.build.sh"
