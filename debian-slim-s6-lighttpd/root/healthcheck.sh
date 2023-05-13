#! /usr/bin/with-contenv /bin/sh
# shellcheck shell=sh

lighttpd="$(wget -Sq -O - --spider http://localhost:${LIGHTTPD_PORT:-8080} 2>&1 | grep -oP 'HTTP[^\s]*\s\K(.*)$')"
echo "Response: ${lighttpd:-none}"

[ "x${lighttpd}" = "x200 OK" ] \
	&& exit 0

exit 1
