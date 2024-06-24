#!/bin/bash

param=$1
flag=$2

username=$(whoami)
gpg_id=$(head -n 1 /home/$username/.vilath/.gpg_id)

edit() {
	if [[ -e "/home/$username/.vilath/$param.gpg" ]]; then
		secret=$(gpg -d -q "/home/$username/.vilath/$param.gpg")
		echo "$secret" > "/home/$username/.vilath/$param"
		shred --remove "/home/$username/.vilath/$param.gpg"
		$EDITOR "/home/$username/.vilath/$param"
		gpg -e -r "$gpg_id" "/home/$username/.vilath/$param"
		shred --remove "/home/$username/.vilath/$param"
		echo "Updated $param"
	fi
}

edit
