#!/bin/bash
# So we can use our ssh-agent forwarding from root

#include
. include/common_functions 

if ! get_done ssh_auth_sock; then 
	cat <<-EOF >> /etc/sudoers.d/99_env_add_ssh_auth_sock.sh
		Defaults env_keep+=SSH_AUTH_SOCK
	EOF
fi
