ARG ALPINE_VERSION="3.13.2"
ARG SOURCE_TAG="${ALPINE_VERSION}"
ARG FROM_IMAGE="alpine:${ALPINE_VERSION}"

## build the image
#
FROM ${FROM_IMAGE}

RUN apk add --no-cache \ 
		curl \
		git \
		jq
	
CMD ["/bin/ash"]
