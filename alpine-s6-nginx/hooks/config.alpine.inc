shopt -s extglob

# the most recent Alpine version
latest_alpine='3.12.0'

# the most recent Alpine minor versions
latest_alpine_minor='+(3.7.3|3.8.5|3.9.6|3.10.5|3.11.6|3.12.0)'

# the Nginx Alpine package versions
function getNginxVersion() {
	case "${1}" in
		3.7*)
			NGINX_VERSION='1.12'
			;;
		3.8*|3.9*)
			NGINX_VERSION='1.14'
			;;
		3.10*|3.11*)
			NGINX_VERSION='1.16'
			;;
		3.12*)
			NGINX_VERSION='1.18'
			;;
	esac
}

# add tags for most recent Nginx versions
function setNginxTag() {
	case ${1} in
		3.7.3)
			tags+=('nginx1.12')
			;;
		3.9.6)
			tags+=('nginx1.14')
			;;
		3.11.6)
			tags+=('nginx1.12')
			;;
		3.12.0)
			tags+=('nginx1.14')
			;;
	esac
}