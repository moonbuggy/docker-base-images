# debian-slim-s6-lighttpd

## Container Details
*   exposed port: `8080`
*   webroot: `/var/www/html`

## Environment

*   `PUID`                - user ID to run as (default: `1000`)
*   `PGID`                - group ID to run as (default: `1000`)
*   `LIGHTTPD_ACCESS_LOG` - enable access logs (accepts: `true`, `false` default: `false`)
*   `LIGHTTPD_DEBUG_LOG`  - enable debug logs (accepts: `true`, `false` default: `false`)
*   `LIGHTTPD_INDEX`      - index files (default: `index.html index.htm`)
*   `LIGHTTPD_PORT`       - default: `8080`
*   `WEB_ROOT`            - default: `/var/www/html`
*   `FIX_PERMISSIONS`     - run _chown_ on `WEB_ROOT` during init (accepts: `true`, `false` default: `false`)
*   `TZ`                  - set `date.timezone` in OS

## Links
GitHub: <https://github.com/moonbuggy/docker-base-images/>

DockerHub: <https://hub.docker.com/r/moonbuggy2000/debian-slim-s6-lighttpd>
