# s6
Containers with nothing but [s6-overlay][s6-repo] inside. These can be used during multi-stage builds to install s6-overlay into an image.

It's easier than making sure any s6-fetching stages in multi-arch builds are identical across different projects and relying on `docker build` caching the layer.

## Usage
```
## get s6 overlay
FROM "moonbuggy2000/s6:${S6_VERSION}-${S6_ARCH}" AS s6

## build image
FROM "${FROM_IMAGE}"
COPY --from=s6 / /

[..]
```

## Tags
Images are tagged in the form `<s6 version>-(<OS>)-<s6 arch>`. The simplest route is to use `latest-<s6 arch>`.

By default (i.e. with `<OS>` omitted) images will contain pre-built binaries from [just-containers/s6-overlay][s6-repo]. Images built from source will not be entirely static and are that tagged to include `<OS>`, indicating the operating system they were built on (e.g. `3.1.1.2-alpine3.16-amd64`).

As there are no pre-built binaries for it in the current releases, the `latest-ppc64le` build contains an old s6 version, v2. All other `latest-<s6 arch>` builds contain a more recent v3 version. This may cause problems in downstream multi-arch builds, so `ppc64le` may need to be dropped from such builds (unless relevant binaries
become available).

The `latest-<OS>-<s6 arch>` images will contain the same version.

Valid pre-built v2 s6 arch: `aarch64/arm64`, `amd64/x86_64`, `arm`, `armhf`, `i386/x86`, `ppc64le`

Valid pre-built v3 s6 arch: `aarch64/arm64`, `amd64/x86_64`, `arm`, `armhf`, `i486/x86`, `i686`, `riscv64`, `s390x`

Valid 'alpine' s6 arch: `aarch64/arm64`, `amd64/x86_64`, `armv6`, `armv7`, `i486/x86`, `i686`, `ppc64le`, `riscv64`, `s390x`

**Note:** In Alpine 3.16 and above it's possible to install s6-overlay v3+ via apk, so once all my Alpine images are rebuilt on the latest release these images may become largely redundant.

## Building
The `./build.sh` command will take arguments in the form `<s6 version>-(<OS>)-<s6 arch>`, or default to `latest` if none is specified.

It's possible to build from source by using `<OS>` set to `alpine(<ver>)`. Omitting `<OS>` will result in a build from the pre-built [just-containers/s6-overlay][s6-repo] binaries.

All possible architectures will be built if no `<s6 arch>` is provided.

## Links
GitHub: <https://github.com/moonbuggy/docker-base-images>

Docker Hub: <https://hub.docker.com/r/moonbuggy2000/s6>

[s6-repo]: <https://github.com/just-containers/s6-overlay>
