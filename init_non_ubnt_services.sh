#!/bin/bash

# Get Absolute path
ABS_PATH="$(readlink -e $BASH_SOURCE)"
ABS_PATH="${ABS_PATH%/*}"

# Includes
source "${ABS_PATH}/include/common_functions"

SERVICES=( 
#	"freeradius"
	"knockd"
)

for i in "${SERVICES[@]}"; do 
	if ! get_done "$i"; then
		update-rc.d "$i" defaults && 
		
		if [[ "$i" == "freeradius" ]]; then
			# Setup the log folder that it expects
			# Fails otherwise	
			log_folder="/var/log/freeradius"
			mkdir -p "$log_folder" &&
			chown -R freerad. "$log_folder" &&
			
			# Make sure symlink is setup for /config/etc/freeradius
			mv /etc/freeradius{,.old} &&
			ln -s /config/etc/freeradius /etc/freeradius
		fi &&

		if [[ "$i" == "knockd" ]]; then
			mv /etc/knockd.conf{,.old} &&
			ln -s /config/etc/knockd.conf /etc/knockd.conf
			sed -ri 's|(START_KNOCKD=)0|\11|' /etc/default/knockd
		fi && 
		service "$i" start &&
		put_done "$i"
	fi
done
