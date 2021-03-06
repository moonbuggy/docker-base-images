# Docker Base Images

Base images to build Docker containers from.

These images are not necessarily suitable for others to use, I may introduce breaking changes without warning or apology as I tailor these images for my requirements.

## add-contenv

These images include a script called `add-contenv` that allows Dockerfiles to add environment variables that are exported by the init system at startup, rather than being applied by Docker.

```
RUN add-contenv <var1>=<value1> <var2>=<value2> ...
```

This is useful because there are some environment variables that don't need user configuration but may change between image builds (e.g. software versions and names of executables). Frontends like Portainer will retain these variables if a new image is pulled, which can break the container if these variables have changed in the image.

## Links

GitHub: https://github.com/moonbuggy/docker-base-images

Docker Hub:
* https://hub.docker.com/r/moonbuggy2000/alpine-builder
* https://hub.docker.com/r/moonbuggy2000/alpine-s6
* https://hub.docker.com/r/moonbuggy2000/alpine-s6-nginx
* https://hub.docker.com/r/moonbuggy2000/alpine-s6-nginx-php-fpm
* https://hub.docker.com/r/moonbuggy2000/alpine-s6-nginx-uwsgi
* https://hub.docker.com/r/moonbuggy2000/alpine-s6-pypy
* https://hub.docker.com/r/moonbuggy2000/debian-slim-s6
* https://hub.docker.com/r/moonbuggy2000/debian-slim-s6-python
* https://hub.docker.com/r/moonbuggy2000/minideb-s6
* https://hub.docker.com/r/moonbuggy2000/minideb-s6-python
