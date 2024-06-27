#!/bin/bash

dir=$1

menu() {
	files=$(tree "$dir" -P *.gpg -i -f --noreport | sed -E 's/\/home\/.*\/\.vilath\///')
	selection=$(echo "$files" | grep ".gpg" | sed -E 's/\.gpg$//' | dmenu)

	if [[ -e "$dir/$selection.gpg" ]]; then
		secret=$(gpg -d -q "$dir/$selection.gpg")
		echo "$secret" | head -n 1 | xclip -selection clipboard
	fi
}

menu
