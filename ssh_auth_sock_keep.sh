#!/bin/bash
# So we can use our ssh-agent forwarding from root

# Get Absolute path
ABS_PATH="$(readlink -e $BASH_SOURCE)"
ABS_PATH="${ABS_PATH%/*}"

# Includes
source "${ABS_PATH}/include/common_functions"

SUDOERSD_CONFIG=/etc/sudoers.d/99_ssh_auth_sock

if ! get_done ssh_auth_sock; then 
	cat <<-EOF >> "${SUDOERSD_CONFIG}"
		Defaults env_keep+=SSH_AUTH_SOCK
	EOF
	chmod 440 "${SUDOERSD_CONFIG}" &&
	put_done ssh_auth_sock
fi &&
