#!/bin/bash

dir=$1
param=$2
flag=$3

gpg_id=$(head -n 1 "$dir/.gpg_id")

edit() {
	if [[ -e "$dir/$param.gpg" ]]; then
		secret=$(gpg -d -q "$dir/$param.gpg")
		echo "$secret" > "$dir/$param"
		shred --remove "$dir/$param.gpg"
		$EDITOR "$dir/$param"
		gpg -e -r "$gpg_id" "$dir/$param"
		shred --remove "$dir/$param"
		echo "Updated $param"
	fi
}

edit
