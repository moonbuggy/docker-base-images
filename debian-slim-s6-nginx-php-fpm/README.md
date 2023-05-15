# debian-slim-s6-nginx-php-fpm

## Container Details
*   exposed port: `8080`
*   webroot: `/var/www/html`
*   PHP-FPM socket: `unix://tmp/php-fpm.sock`

## Environment
*   `PUID`          - user ID to run as (default: `1000`)
*   `PGID`          - group ID to run as (default: `1000`)
*   `NGINX_LOG_ALL` - enable logging of HTTP 200 and 300 responses (accepts: `true`, `false` default: `false`)
*   `NGINX_INDEX`   - index files (default: `index.php index.html index.htm`)
*   `NGINX_PORT`    - default: `8080`
*   `WEB_ROOT`      - default: `/var/www/html`
*   `MAKE_PHPINFO`  - make `phpinfo.php` in `WEB_ROOT` (accepts: `true`, `false` default: `false`)
*   `TZ`            - set `date.timezone` in OS and php.ini

## Links
GitHub: <https://github.com/moonbuggy/docker-base-images>

DockerHub: <https://hub.docker.com/r/moonbuggy2000/debian-slim-s6-nginx-php-fpm>
