# alpine-s6

Alpine versions below 3.16 will have s6-overlay installed via [moonbuggy2000/s6](../s6), versions 3.16 and above are installed as packages from the Alpine package repo.

Currently all recent Alpine versions should have s6-overlay v3 installed, but below Alpine 3.12 some __ppc64le__ images may be running v2 and some architectures may not have builds at all.

## Environment
*   `TZ`		      - set timezone

## Links
GitHub: <https://github.com/moonbuggy/docker-base-images>

DockerHub: <https://hub.docker.com/r/moonbuggy2000/alpine-s6>
