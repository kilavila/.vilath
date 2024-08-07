#!/bin/bash

function vps_initialize {
	DIR="$1"
	GPG_ID="$2"

	echo "${RED}┬"

	if [[ -e "$DIR/.vps_gpg_id" ]]; then
		echo "│ Password Store already initialized!"
		read -p "${RED}│ ${GREY}Would you like to ${YELLOW}overwrite the GnuPG ID${GREY}? [y/N] " CONFIRM
		if [[ "$CONFIRM" == "Y" || "$CONFIRM" == "y" ]]; then
			echo "${RED}└── ${GREY}GnuPG ID overwritten!"
			echo "$GPG_ID" > "$DIR/.vps_gpg_id"
		fi
	else
		echo "└── ${GREEN}Password Store initialized!"
		echo "$GPG_ID" > "$DIR/.vps_gpg_id"
	fi
}
