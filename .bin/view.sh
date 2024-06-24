#!/bin/bash

param=$1
flag=$2

username=$(whoami)

view() {
	if [[ -e "/home/$username/.vilath/$param.gpg" ]]; then
		secret=$(gpg -d -q "/home/$username/.vilath/$param.gpg")

		if [[ -n "$flag" && "$flag" == "-c" ]]; then
			echo "$secret" | head -n 1 | xclip -selection clipboard
			echo "Password has been copied to clipboard"
		elif [[ -n "$flag" && "$flag" == "-a" ]]; then
			echo "$secret"
		else
			echo "$secret" | tail +2
		fi
	fi
}

view
