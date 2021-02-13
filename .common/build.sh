#! /bin/bash

[ -n "${NOOP}" ] && printf '** NOOP set. Will not execute pushes.\n\n'

printf 'image name: %s\n\n' "${IMAGE_NAME}"

. hooks/post_checkout
. hooks/pre_build
. hooks/build
. hooks/push
. hooks/post_push

