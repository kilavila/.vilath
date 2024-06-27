#!/bin/bash

dir=$1
param=$2
flag=$3

view() {
	if [[ -e "$dir/$param.gpg" ]]; then
		secret=$(gpg -d -q "$dir/$param.gpg")

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
