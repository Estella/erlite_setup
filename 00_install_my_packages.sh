#!/bin/bash

QUIET=""
#QUIET="-qq"

# Get Absolute path
ABS_PATH="$(readlink -e $BASH_SOURCE)"
ABS_PATH="${ABS_PATH%/*}"

# Includes
source "${ABS_PATH}/include/common_functions"

packages=(
	"vim"
	"tmux"
	"htop"
	"dnsutils"
	"harden-tools"
	"ngrep"
	"tcpdump"
	"man"
#	"iperf3"
	"git"
	"wget"
#	"freeradius" # CRITICAL
	"knockd" # CRITICAL
	"apt-utils"
	"apt-file"
)

if ! get_done "packages"; then
	apt-get update &&
	apt-get install -y "${packages[@]}" && 

	if [[ "$?" == 0 ]]; then 
		echo "package install successful" 
		put_done "packages"
	else
		echo "package install failed"
	fi
fi
