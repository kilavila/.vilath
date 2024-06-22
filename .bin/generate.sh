#!/bin/bash

param=$1
flag=$2

username=$(whoami)
gpg_id=$(head -n 1 /home/$username/.vilath/.gpg_id)
password=$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+-={}:<>?[]|~')

generate() {
	if [[ -e "/home/$username/.vilath/$param" ]]; then
		echo "Found existing file: $param"
		read -p "Would you like to overwrite this password file? y/N " overwrite

		if [[ "$overwrite" == "y" ]]; then
			rm "/home/$username/.vilath/$param.gpg"
			echo "Generated new password for: $param"
			echo "$password" > "/home/$username/.vilath/$param"
			gpg -e -r "$gpg_id" "/home/$username/.vilath/$param"
			shred --remove "/home/$username/.vilath/$param"

			if [[ -n "$flag" && "$flag" == "-c" ]]; then
				echo "$password" | xclip -selection clipboard
				echo "Password has been copied to clipboard"

				return 0
			else
				echo "$password"
			fi
		fi

		return 0
	else
		echo "Generating new password"

		if [[ "$param" =~ \/ ]]; then
			path=$(echo "$param" | sed -E 's/\/\w+$//')

			if [[ -n "$path" && ! -d "/home/$username/.vilath/$path" ]]; then
				mkdir -p "/home/$username/.vilath/$path"
			fi
		fi

		echo "$password" > "/home/$username/.vilath/$param"
		gpg -e -r "$gpg_id" "/home/$username/.vilath/$param"
		shred --remove "/home/$username/.vilath/$param"

		if [[ -n "$flag" && "$flag" == "-c" ]]; then
			echo "$password" | xclip -selection clipboard
			echo "Password has been copied to clipboard"

			return 0
		else
			echo "$password"
		fi
	fi
}

generate
