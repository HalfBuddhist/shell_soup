get_distro() {
	distro=""
	# Every system that we officially support has /etc/os-release
	if [ -r /etc/os-release ]; then
		distro="$(. /etc/os-release && echo "$ID")"
	fi
	# Returning an empty string here should be alright since the
	# case statements don't act unless you provide an actual value
	echo "$distro" | tr '[:upper:]' '[:lower:]'
}

echo $(get_distro)
