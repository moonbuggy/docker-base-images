ARG QEMU_PREFIX="amd64"
ARG BUILDER_REPO="alpine"

# use an Alpine version that is end of life, so it should remain the highest
# highest minor version and have the best odds of already being cached by
# other builds
ARG BUILDER_TAG="3.10.9"

ARG BUILDER_FROM="${QEMU_PREFIX}/${BUILDER_REPO}:${BUILDER_TAG}"

FROM "${BUILDER_FROM}" AS builder

# QEMU static binaries from pre_build
ARG QEMU_DIR=""
ARG QEMU_ARCH=""
COPY _dummyfile "${QEMU_DIR}/qemu-${QEMU_ARCH}-static*" /usr/bin/

ARG QEMU_PREFIX
RUN echo "${QEMU_PREFIX}" > /.arch

FROM scratch

COPY --from=builder /.arch /
