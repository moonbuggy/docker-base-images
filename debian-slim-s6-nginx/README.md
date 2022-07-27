# debian-slim-s6-nginx

## Container Details

*   exposed port: `8080`
*   webroot: `/var/www/html`

## Environment

*   `PUID`          - user ID to run as
*   `PGID`          - group ID to run as
*   `NGINX_LOG_ALL` - enable logging of HTTP 200 and 300 responses (accepts: `true`, `false` default: `false`)
*   `NGINX_INDEX`   - index files (default: `index.html index.htm`)
*   `NGINX_PORT`    - default: `8080`
*   `WEB_ROOT`      - default: `/var/www/html`

## Links
GitHub: <https://github.com/moonbuggy/docker-base-images/>

DockerHub: <https://hub.docker.com/r/moonbuggy2000/debian-slim-s6-nginx>
