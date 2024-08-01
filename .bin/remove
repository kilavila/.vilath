#!/bin/bash

function vps_remove {
	DIR="$1"
	SOURCE="$2"

	echo "${RED}┬"

	if [[ -e "$DIR/$SOURCE.gpg" ]]; then

		echo "│   Deleting password file, this action is NOT reversible!"
		read -p "${RED}│   ${GREY}Would you like to ${YELLOW}remove the password file${GREY}? [y/N] " CONFIRM
		echo "${RED}│"

		if [[ "$CONFIRM" == "Y" || "$CONFIRM" == "y" ]]; then
			rm -f "$DIR/$SOURCE.gpg"
			echo "└── ${GREY}Password file deleted: ${GREEN}$SOURCE"
		else
			echo "└── ${GREY}Aborted"
		fi

	elif [[ -d "$DIR/$SOURCE" ]]; then

		echo "│   WARNING! Deleting directory, this action is NOT reversible!"
		read -p "${RED}│   ${GREY}Would you like to ${YELLOW}remove the directory and all the password files within it${GREY}? [y/N] " CONFIRM
		echo "${RED}│"

		if [[ "$CONFIRM" == "Y" || "$CONFIRM" == "y" ]]; then
			rm -rf "$DIR/$SOURCE"
			echo "└── ${GREY}Password directory deleted: ${GREEN}$SOURCE"
		else
			echo "└── ${GREY}Aborted"
		fi

	else

		echo "│   Error!"
		echo "└── ${GREY}File or directory not found: ${YELLOW}$SOURCE"

	fi
}
