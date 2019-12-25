# alpine-s6-nginx-uwsgi

## Container Details

* exposed port: `8080`
* webroot: `/var/www/html`
- uWSGI socket: `unix://tmp/uwsgi.sock`

## Environment

* `PUID`          - user ID to run as
* `PGID`          - group ID to run as
* `NGINX_LOG_ALL` - enable logging of HTTP 200 and 300 responses (accepts: `true`, `false` default: `false`)
* `UWSGI_LOG`     - enable logging from uWSGI (accepts: `true`, `false` default: `false`)
