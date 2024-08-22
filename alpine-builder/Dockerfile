ARG ALPINE_VERSION="3.13.2"
ARG SOURCE_TAG="${ALPINE_VERSION}"
ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"

ARG QEMU_ARCH="arm"

## build the image
#
FROM multiarch/qemu-user-static:x86_64-${QEMU_ARCH} AS qemu
FROM "${FROM_IMAGE}"

# QEMU static binaries from pre_build
ARG QEMU_ARCH
COPY --from=qemu /usr/bin/qemu-${QEMU_ARCH}-static /usr/bin

ARG BUILD_DIR=/build

WORKDIR "${BUILD_DIR}"

# use a local APK caching proxy, if one is provided
ARG APK_PROXY=""
ARG ALPINE_MINOR
RUN if [ ! -z "${APK_PROXY}" ]; then \
    mv /etc/apk/repositories /etc/apk/repositories.bak; \
		echo "${APK_PROXY}/alpine/v${ALPINE_MINOR}/main" >/etc/apk/repositories; \
		echo "${APK_PROXY}/alpine/v${ALPINE_MINOR}/community" >>/etc/apk/repositories; \
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
	&& adduser -D -h /build/ -G abuild builder \
	&& chown -R builder:abuild /build \
	&& chgrp abuild /var/cache/distfiles/ \
	&& chmod g+w /var/cache/distfiles/ \
	&& echo "builder	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
	&& echo "Set disable_coredump false" >> /etc/sudo.conf \
	&& abuild-keygen -a -i -n \
  && (mv -f /etc/apk/repositories.bak /etc/apk/repositories || true)

#USER builder

CMD ["/bin/ash"]
