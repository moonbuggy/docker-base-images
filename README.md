# Docker Base Images
Base images to build Docker containers from.

These images are not necessarily suitable for others to use, I may introduce breaking changes without warning or apology as I tailor these images for my requirements.

## add-contenv
Most of these images include an `add-contenv` script that allows Dockerfiles to add environment variables that are exported by the init system at startup, rather than being applied by Docker's ENV.

```
RUN add-contenv <var1>=<value1> <var2>=<value2> ...
```

The `add-contenv` environment variables are set by the `add-contenv` service in s6-overlay v3+. This service should be set a dependency for any other services that require these variables, which will be available in the normal way via `with-contenv`.

See [add-contenv](https://github.com/moonbuggy/docker-s6-add-contenv) for more details.


## Links
GitHub:
*   <https://github.com/moonbuggy/docker-base-images>
*   <https://github.com/moonbuggy/docker-s6-overlay>
*   <https://github.com/moonbuggy/docker-s6-add-contenv>

Docker Hub:
*   <https://hub.docker.com/r/moonbuggy2000/alpine-builder>
*   <https://hub.docker.com/r/moonbuggy2000/alpine-python-builder>
*   <https://hub.docker.com/r/moonbuggy2000/alpine-s6>
*   <https://hub.docker.com/r/moonbuggy2000/alpine-s6-nginx>
*   <https://hub.docker.com/r/moonbuggy2000/alpine-s6-nginx-php-fpm>
*   <https://hub.docker.com/r/moonbuggy2000/alpine-s6-nginx-uwsgi>
*   <https://hub.docker.com/r/moonbuggy2000/alpine-s6-node>
*   <https://hub.docker.com/r/moonbuggy2000/alpine-s6-node-nginx>
*   <https://hub.docker.com/r/moonbuggy2000/alpine-s6-pypy>
*   <https://hub.docker.com/r/moonbuggy2000/alpine-s6-python>
*   <https://hub.docker.com/r/moonbuggy2000/debian-builder>
*   <https://hub.docker.com/r/moonbuggy2000/debian-slim-s6>
*   <https://hub.docker.com/r/moonbuggy2000/debian-slim-s6-lighttpd>
*   <https://hub.docker.com/r/moonbuggy2000/debian-slim-s6-lighttpd-php-cgi>
*   <https://hub.docker.com/r/moonbuggy2000/debian-slim-s6-nginx>
*   <https://hub.docker.com/r/moonbuggy2000/debian-slim-s6-nginx-php-fpm>
*   <https://hub.docker.com/r/moonbuggy2000/debian-slim-s6-pypy>
*   <https://hub.docker.com/r/moonbuggy2000/debian-slim-s6-python>
*   <https://hub.docker.com/r/moonbuggy2000/minideb-s6>
*   <https://hub.docker.com/r/moonbuggy2000/minideb-s6-python>
*   <https://hub.docker.com/r/moonbuggy2000/fetcher>
*   <https://hub.docker.com/r/moonbuggy2000/nuitka>
*   <https://hub.docker.com/r/moonbuggy2000/s6-overlay>
*   <https://hub.docker.com/r/moonbuggy2000/s6-add-contenv>
*   <https://hub.docker.com/r/moonbuggy2000/scratch>
