ARG NGINX_VERSION="1.22"
ARG FROM_IMAGE="moonbuggy2000/alpine-s6-nginx:${NGINX_VERSION}"

## prepare config files
#
FROM "${FROM_IMAGE}" AS config

COPY root/ /config_root/
WORKDIR /config_root/etc/

# determine the s6 overlay major version in use, remove any uneeded config
#   v2.* uses /etc/s6,  v3.* uses /etc/s6-overlay
RUN if [ -d "/etc/s6" ]; then \
    echo "*** Removing s6-overlay V3 init scripts.."; \
    rm -rvf s6-overlay 2>/dev/null; \
  elif [ -d "/etc/s6-overlay" ]; then \
    echo "*** Removing s6-overlay V2 init scripts.."; \
    rm -rvf cont-init.d services.d fix-attrs.d 2>/dev/null; \
  fi

## build the image
#
FROM "${FROM_IMAGE}"

COPY --from=config /config_root/ /

ENTRYPOINT ["/init"]
