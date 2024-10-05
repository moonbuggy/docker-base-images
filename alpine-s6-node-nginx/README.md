# alpine-s6-node-nginx

Nginx is configured as reverse proxy, proxying to a Node.js app running on
`NODE_PORT`.

## Container Details
*   exposed port: `8080`
*   config mount: `/etc/nginx/http.d/`

## Environment
*   `PUID`          - user ID to run as (default: `1000`)
*   `PGID`          - group ID to run as (default: `1000`)
*   `NGINX_LOG_ALL` - enable logging of HTTP 200 and 300 responses (accepts: `true`, `false` default: `false`)
*   `NGINX_PORT`    - outward facing Nginx port (default: `8080`)
*   `NODE_PORT`     - Node app port for Nginx to proxy to (default: `3000`)
*   `TZ`            - set timezone

## Links
GitHub: <https://github.com/moonbuggy/docker-base-images>

DockerHub: <https://hub.docker.com/r/moonbuggy2000/alpine-s6-node-nginx>
