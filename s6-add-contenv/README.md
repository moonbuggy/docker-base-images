# s6-add-contenv
Scripts to set environment variables in a container at run time, without using Docker's ENV.

This is useful because there are some environment variables that don't need user configuration but are needed for the application and may change between image builds (e.g. software versions, git hashes, paths/names of executables). Frontends like Portainer will retain these environment variables if a new image is pulled, which can break the container if these variables have changed in the image.

## Usage
These images contain an `add-contenv` script, to set environment variables in a Dockerfile, and the [s6-overlay][] configuration to export them during container init. The image contents should be copied to the root folder of the image they're to be used in, as part of a multi-stage build.

[s6-overlay][] will also need to be installed in the container to execute the init scripts.

Once the scripts are available, assuming `/usr/local/bin/` is in the path, `add-contenv` can be used in the Dockerfile. It's also possible to directly add environment variables by adding them to `/etc/contenv_extra`.

In s6 overlay v3 explicit service dependencies are used, so the `add-contenv` service should be set as a dependency for any services that depend on it.

In s6 overlay v2 the cont-init.d script is `00-add-contenv`, so any other services that depend on it should have a larger number as a prefix.

For example:
```
## get s6-overlay
FROM moonbuggy2000/fetcher:latest AS s6-overlay
WORKDIR /s6-root/
# .. prepare s6-overlay files ..

## get add-contenv
FROM moonbuggy2000/s6-add-contenv:s6-overlay-v3 AS add-contenv

## build the final image
FROM alpine:3.16.0
COPY --from=s6-overlay /s6-root/ /
COPY --from=add-contenv / /

# using 'add-contenv'
RUN add-contenv ALPINE_VERSION=3.16.0 ALPINE_MINOR_VERSION=3.16

# OR
# direct addition
RUN echo "ALPINE_VERSION=3.16.0" >> /etc/contenv_extra \
  && echo "ALPINE_MINOR_VERSION=3.16" >> /etc/contenv_extra

# .. install 'my_app', configure `my_app` s6-rc.d service ..

# add dependency to `my_app` service
RUN mkdir -p /etc/s6-overlay/s6-rc.d/my_app/dependencies.d/ \
  && touch /etc/s6-overlay/s6-rc.d/my_app/dependencies.d/add-contenv

# .. do all the other things ..

ENTRYPOINT ['/init']
```

The variables will be exported as normal [s6-overlay environment variables](s6-overlay#container-environment) and be available via `with-contenv`.

Container logs will include `add-contenv: info: ..` messages during init to indicate any environment variables set via `add-contenv`. (Environment variables from `docker run -e [..]` or a `docker-compose.yml` file will not be logged by add-contenv, however they will continue to work normally.)

### Tags
The init system in s6-overlay changed between v2 and v3. As a result this repo contains init scripts for both v2 (`cont-init.d`) and v3 (`s6-rc.d`), with images containing one or both of these.

Valid tags: `s6-overlay-v2`, `s6-overlay-v3`, `s6-overlay-all`

#### s6-overlay-all
The `s6-overlay-all` image, containing both s6-overlay v2 and v3 init scripts, provides some flexibility in cases where the s6-overlay version in an upstream image might be expected to change or isn't otherwise known before reaching its layer in the Dockerfile.

Although it shouldn't do any harm, s6-overlay v3 will execute both v2 and v3 init scripts. To avoid pointless duplication the un-needed scripts should be removed once it's appropriate.

One option is to determine the s6-overlay version from the presence of the `/etc/` folders the different versions create:
```
FROM moonbuggy2000/s6-add-contenv:s6-overlay-all AS add-contenv

FROM not_a_real_image/alpine-s6:mystery_s6_overlay_version
COPY --from=add-contenv / /

RUN if [ -d "/etc/s6" ]; then \
    echo "*** Removing s6-overlay v3 init scripts.."; \
    rm -rvf /etc/s6-overlay 2>/dev/null; \
  elif [ -d "/etc/s6-overlay" ]; then \
    echo "*** Removing s6-overlay v2 init scripts.."; \
    rm -rvf /etc/cont-init.d 2>/dev/null; \
  fi

# .. et cetera ..
```

## Links
GitHub: <https://github.com/moonbuggy/docker-base-images>

Docker Hub: <https://hub.docker.com/r/moonbuggy2000/s6-add-contenv>

[s6-overlay]: <https://github.com/just-containers/s6-overlay>
