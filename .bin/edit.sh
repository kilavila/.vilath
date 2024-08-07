#!/bin/bash

function vps_edit {
	DIR="$1"
	FILE="$2"

	echo "${RED}┬"

	if [[ -e "$DIR/$FILE.gpg" ]]; then
		CONTENT=$(vps_decrypt "$DIR" "$FILE")
		echo "$CONTENT" > "$DIR/$FILE"
		$EDITOR "$DIR/$FILE"
		vps_encrypt "$DIR" "$FILE"
		echo "└── ${GREY}Password file ${GREEN}updated ${GREY}and ${GREEN}encrypted${GREY}!"
	fi
}
