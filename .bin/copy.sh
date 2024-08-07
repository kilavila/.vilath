#!/bin/bash

function vps_copy {
	DIR="$1"
	SOURCE_FILE="$2"
	TARGET_FILE="$3"

	echo "${RED}┬"

	if [[ -e "$DIR/$TARGET_FILE.gpg" ]]; then

		echo "│   Password file already exist!"
		read -p "${RED}│   ${GREY}Would you like to ${YELLOW}overwrite the existing file${GREY}? [y/N] " CONFIRM

		if [[ "$CONFIRM" == "Y" || "$CONFIRM" == "y" ]]; then
			cp "$DIR/$SOURCE_FILE.gpg" "$DIR/$TARGET_FILE.gpg"
			echo "│"
			echo "${RED}└── ${GREY}Password file copied: ${BLUE}$SOURCE_FILE ${GREY}-> ${GREEN}$TARGET_FILE"
		fi

	else

		if [[ "$TARGET_FILE" =~ \/ ]]; then
			DIRECTORIES=$(echo "$TARGET_FILE" | sed -E 's/^(.*)\/.*$/\1/')

			if [[ -n "$DIRECTORIES" && ! -d "$DIR/$DIRECTORIES" ]]; then
				mkdir -p "$DIR/$DIRECTORIES"
			fi
		fi

		cp "$DIR/$SOURCE_FILE.gpg" "$DIR/$TARGET_FILE.gpg"
		echo "${RED}└── ${GREY}Password file copied: ${BLUE}$SOURCE_FILE ${GREY}-> ${GREEN}$TARGET_FILE"
	fi
}
