#! /bin/bash
# shellcheck shell=bash disable=SC2034

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/fetcher}"

all_tags='latest'
default_tag='latest'

. "hooks/.build.sh"
