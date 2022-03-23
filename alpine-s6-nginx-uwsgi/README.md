# alpine-s6-nginx-uwsgi

## Container Details
*   exposed port: `8080`
*   webroot: `/var/www/html`
*   uWSGI socket: `unix://tmp/uwsgi.sock`

## Environment
*   `PUID`          - user ID to run as
*   `PGID`          - group ID to run as
*   `NGINX_LOG_ALL` - enable logging of HTTP 200 and 300 responses (accepts: `true`, `false` default: `false`)
*   `UWSGI_LOG`     - enable logging from uWSGI (accepts: `true`, `false` default: `false`)
*   `NGINX_INDEX`   - index files (default: `index.php index.html index.htm`)
*   `NGINX_PORT`    - default: `8080`
*   `WEB_ROOT`      - default: `/var/www/html`
*   `TZ`            - set timezone

## Links
GitHub: <https://github.com/moonbuggy/docker-base-images>

DockerHub: <https://hub.docker.com/r/moonbuggy2000/alpine-s6-nginx-uwsgi>
