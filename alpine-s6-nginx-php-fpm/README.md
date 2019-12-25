# alpine-s6-nginx-php-fpm

## Container Details

* exposed port: `8080`
* webroot: `/var/www/html`
* PHP-FPM socket: `unix://tmp/php-fpm.sock`

## Environment

* `PUID`          - user ID to run as
* `PGID`          - group ID to run as
* `TZ`		      - set `date.timezone` in php.ini
* `NGINX_LOG_ALL` - enable logging of HTTP 200 and 300 responses (accepts: `true`, `false` default: `false`)
