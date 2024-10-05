ARG ALPINE_VERSION="3.20.3"
ARG SOURCE_TAG="${ALPINE_VERSION}"
ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"

ARG QEMU_ARCH="arm"

## get QEMU static binaries
#
FROM multiarch/qemu-user-static:x86_64-${QEMU_ARCH} AS qemu

## build the image
#
FROM "${FROM_IMAGE}"

# QEMU static binaries from pre_build
ARG QEMU_ARCH
COPY --from=qemu /usr/bin/qemu-${QEMU_ARCH}-static /usr/bin

ARG BUILD_DIR="/build"

WORKDIR "${BUILD_DIR}"

# use a local APK caching proxy, if one is provided
ARG APK_PROXY=""

RUN if [ ! -z "${APK_PROXY}" ]; then \
    alpine_minor_ver="$(grep -o 'VERSION_ID.*' /etc/os-release | grep -oE '([0-9]+\.[0-9]+)')"; \
    mv /etc/apk/repositories /etc/apk/repositories.bak; \
    echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/main" >/etc/apk/repositories; \
    echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/community" >>/etc/apk/repositories; \
	fi \
  && apk -U add --no-cache \
		alpine-sdk \
		autoconf \
		bison \
		clang \
		flex \
		git \
		linux-headers \
		sudo \
  && (mv -f /etc/apk/repositories.bak /etc/apk/repositories >/dev/null 2>&1 || true) \
	&& adduser -D -h /build/ -G abuild builder \
	&& chown -R builder:abuild /build \
	&& chgrp abuild /var/cache/distfiles/ \
	&& chmod g+w /var/cache/distfiles/ \
	&& echo "builder	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
	&& echo "Set disable_coredump false" >> /etc/sudo.conf \
	&& abuild-keygen -a -i -n

#USER builder

CMD ["/bin/ash"]
