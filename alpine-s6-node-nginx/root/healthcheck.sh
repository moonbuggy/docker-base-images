#! /usr/bin/with-contenv /bin/sh

nginx="$(wget -qO- http://localhost:${NGINX_PORT:-8080}/nginx-ping)"

echo "Nginx ping: ${nginx}"

[ "x${nginx_fpm}" = "xpong" ] \
	&& exit 0

exit 1
