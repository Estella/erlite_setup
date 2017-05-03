#!/bin/bash

QUIET=""
QUIET="-qq"

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
	"git"
	"wget"
	"fwknop-server"
	"apt-utils"
	"apt-file"
	"dialog"
	"tree"
)

if ! get_done "packages"; then
	apt-get $QUIET -y update &&
	apt-get $QUIET -y install "${packages[@]}" &&

	if [[ "$?" == 0 ]]; then 
		echo "package install successful" 
		put_done "packages"
	else
		echo "package install failed"
	fi
fi
