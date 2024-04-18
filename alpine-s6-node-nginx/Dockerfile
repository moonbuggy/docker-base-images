# syntax = docker/dockerfile:1.4.0

ARG NODE_VERSION="16"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6-node:${NODE_VERSION}"

## build the image
#
FROM "${FROM_IMAGE}"

ARG	WEB_ROOT="/var/www/html"

# use a local APK caching proxy, if one is provided
ARG APK_PROXY=""
RUN if [ ! -z "${APK_PROXY}" ]; then \
		alpine_minor_ver="$(grep -o 'VERSION_ID.*' /etc/os-release | grep -oE '([0-9]+\.[0-9]+)')"; \
    mv /etc/apk/repositories /etc/apk/repositories.bak; \
		echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/main" >/etc/apk/repositories; \
		echo "${APK_PROXY}/alpine/v${alpine_minor_ver}/community" >>/etc/apk/repositories; \
	fi \
  && apk -U add --no-cache \
		nginx \
		shadow \
	&& rm -rf /etc/nginx/conf.d 2>/dev/null \
	&& ln -sf /etc/nginx/http.d /etc/nginx/conf.d \
	&& rm -rf /var/www/localhost 2>/dev/null \
	&& mkdir -p "${WEB_ROOT}" \
	&& adduser -DH -G www-data www-data \
	&& chown -R www-data:www-data "${WEB_ROOT}" \
	&& chown -R www-data:www-data /var/lib/nginx \
  && (mv -f /etc/apk/repositories.bak /etc/apk/repositories || true)

COPY root/ /

ARG NGINX_PORT="8080"
ARG NODE_PORT="3000"
ENV NGINX_PORT="${NGINX_PORT}" \
		NODE_PORT="${NODE_PORT}" \
		WEB_ROOT="${WEB_ROOT}"

EXPOSE "${NGINX_PORT}"

ENTRYPOINT ["/init"]

HEALTHCHECK --start-period=10s --timeout=10s CMD /healthcheck.sh
