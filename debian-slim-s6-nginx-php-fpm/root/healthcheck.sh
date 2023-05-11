#! /usr/bin/with-contenv /bin/sh

php_fpm="$(wget -qO- http://localhost:${NGINX_PORT:-8080}/fpm-ping)"

echo "PHP-FPM ping: ${php_fpm}"

[ "x${php_fpm}" = "xpong" ] \
	&& exit 0

exit 1
