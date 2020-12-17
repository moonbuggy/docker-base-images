## get the repo and tag strings
#
image_repo=${IMAGE_NAME%:*}
image_tag=${IMAGE_NAME#*:}

if [ "${image_tag}" = "latest" ]; then
	image_tag=$latest
fi

## generate and apply extra tags
#
tags=()

if [ "${image_tag}" = "${latest}" ]; then
	tags+=('latest')
fi

## push the tags
#
push_tags()	{
	for tag in ${tags[@]}; do
		echo '---'
		printf 'Adding tag: %s:%s\n' "${image_repo}" "${tag}"
		docker tag $IMAGE_NAME ${image_repo}:${tag}
		docker push ${image_repo}:${tag} | grep digest
	done
	echo '---'
}
