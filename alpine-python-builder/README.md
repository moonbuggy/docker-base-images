# alpine-python-builder

This is an Alpine container for building Python projects, for use as part of a
multi-stage build.

Primarily used for [building musl wheels](https://github.com/moonbuggy/docker-python-musl-wheels).

## Installed Packages
### Alpine Packages
*   cargo
*   ccache
*   gcc
*   git
*   libffi-dev
*   make
*   musl-dev
*   musl-utils
*   patchelf
*   rust

### Python modules
*   auditwheel
*   pip

## Build Environment
*   `APK_PROXY`     - URL for the Alpine repository to use (accepts: `http(s)://host(:port)`)
*   `PYPI_INDEX`    - URL for the PyPi index to use (accepts: `http(s)://host(:port)`)

These are optional, overriding the defaults if we have local caching proxies or
a preference for a particular external repository. Leave unset to retain the
default settings.

## Links
GitHub: <https://github.com/moonbuggy/docker-base-images>

Docker Hub: <https://hub.docker.com/r/moonbuggy2000/alpine-python-builder>
