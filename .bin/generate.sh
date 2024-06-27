#!/bin/bash

dir=$1
param=$2
flag=$3

gpg_id=$(head -n 1 "$dir/.gpg_id")
password=$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+-={}:<>?[]|~')

generate() {
	if [[ -e "$dir/$param" ]]; then
		echo "Found existing file: $param"
		read -p "Would you like to overwrite this password file? y/N " overwrite

		if [[ "$overwrite" == "y" ]]; then
			rm "$dir/$param.gpg"
			echo "Generated new password for: $param"
			echo "$password" > "$dir/$param"
			gpg -e -r "$gpg_id" "$dir/$param"
			shred --remove "$dir/$param"

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

			if [[ -n "$path" && ! -d "$dir/$path" ]]; then
				mkdir -p "$dir/$path"
			fi
		fi

		echo "$password" > "$dir/$param"
		gpg -e -r "$gpg_id" "$dir/$param"
		shred --remove "$dir/$param"

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
