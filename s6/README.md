# s6
Containers with nothing but [s6 overlay](https://github.com/just-containers/s6-overlay) inside. Effectively a cache, to minimize pulling and untarring from the Git repo.

It's easier than making sure any s6-fetching stages in multi-arch builds are identical scross different projects and relying on `docker build` caching the layer.

## Tags
Images are taggsd in the form `<s6 version>-<s6 arch>`. The simplest route is to use `latest-<s6 arch>`.

Valid s6 arches: `aarch64`, `amd64`, `arm`, `armhf`, `arm64`, `ppc64le`, `x86`

## Usage
```
## get s6 overlay
FROM "moonbuggy2000/s6:${S6_VERSION}-${S6_ARCH}" AS s6

## build image
FROM "${FROM_IMAGE}"
COPY --from=s6 / /

[..]
```

## Links
GitHub: https://github.com/moonbuggy/docker-base-images

Docker Hub: https://hub.docker.com/r/moonbuggy2000/s6
