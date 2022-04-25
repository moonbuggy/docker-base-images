# alpine-s6-pypy

## Environment
*   `TZ`          - timezone

## Notes
The `add-contenv` environment variables are set by the `contenv` service. This service should be set a dependency in any downstream image services that want these variables available via `with-contenv`.

## Links
GitHub: <https://github.com/moonbuggy/docker-base-images>

DockerHub: <https://hub.docker.com/r/moonbuggy2000/alpine-s6-pypy>
