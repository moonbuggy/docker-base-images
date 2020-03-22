ARG ALPINE_VERSION=3.11.3

FROM alpine:$ALPINE_VERSION

RUN apk add --no-cache \ 
		curl \
		git \
		jq
	
CMD ["/bin/ash"]
