# scratch
Arch-specific scratch containers.

Things go a bit silly with multi-arch builds sometimes. A `scratch` container with a platform architecture pre-attached helps ensure a multi-stage build which makes use of `scratch` creates a final image with the intended plaftorm.

## Tags
Tags match the architecture, so basically: `moonbuggy2000/scratch:<arch>`

Some architectures have multiple tags to simplify downstream scripting.

Arch | Platform | Tag(s)
-----|----------|--------
386 | linux/386 | 386
amd64 | linux/amd64 | amd64
arm32v5 | linux/arm/v5 | arm32v5 armv5
arm32v6 | linux/arm/v6 | arm32v6 armv6
arm32v7 | linux/arm/v7 | arm32v7 armv7
arm64v8 | linux/arm64/v8 | arm64v8 arm64
ppc64le | linux/ppc64le | ppc64le
s390x | linux/s390x | s390x

## Links
GitHub: https://github.com/moonbuggy/docker-base-images

Docker Hub: https://hub.docker.com/r/moonbuggy2000/scratch
