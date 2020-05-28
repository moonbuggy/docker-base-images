ARG ALPINE_VERSION=3.12.0

FROM alpine:$ALPINE_VERSION

RUN apk add --no-cache \ 
		curl \
		git \
		jq
	
CMD ["/bin/ash"]
