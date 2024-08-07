#!/bin/bash

function vps_remove_empty_dir {
	DIR="$1"
	SOURCE_FILE="$2"

	if [[ "$SOURCE_FILE" =~ \/ ]]; then
		DIRECTORIES=$(echo "$SOURCE_FILE" | sed -E 's/^(.*)\/.*$/\1/')

		if [[ -n "$DIRECTORIES" && -d "$DIR/$DIRECTORIES" ]]; then
			CHILD_ITEMS=$(ls "$DIR/$DIRECTORIES")

			if ! [[ "$CHILD_ITEMS" ]]; then
				rm -rf "$DIR/$DIRECTORIES"
			fi
		fi
	fi
}

function vps_move {
	DIR="$1"
	SOURCE_FILE="$2"
	TARGET_FILE="$3"

	echo "${RED}┬"

	if [[ -e "$DIR/$TARGET_FILE.gpg" ]]; then

		echo "│   Password file already exist!"
		read -p "${RED}│   ${GREY}Would you like to ${YELLOW}overwrite the existing file${GREY}? [y/N] " CONFIRM

		if [[ "$CONFIRM" == "Y" || "$CONFIRM" == "y" ]]; then
			mv -f "$DIR/$SOURCE_FILE.gpg" "$DIR/$TARGET_FILE.gpg"
			vps_remove_empty_dir "$DIR" "$SOURCE_FILE"
			echo "│"
			echo "${RED}└── ${GREY}Password file moved: ${BLUE}$SOURCE_FILE ${GREY}-> ${GREEN}$TARGET_FILE"
		fi

	else

		if [[ "$TARGET_FILE" =~ \/ ]]; then
			DIRECTORIES=$(echo "$TARGET_FILE" | sed -E 's/^(.*)\/.*$/\1/')

			if [[ -n "$DIRECTORIES" && ! -d "$DIR/$DIRECTORIES" ]]; then
				mkdir -p "$DIR/$DIRECTORIES"
			fi
		fi

		mv "$DIR/$SOURCE_FILE.gpg" "$DIR/$TARGET_FILE.gpg"
		vps_remove_empty_dir "$DIR" "$SOURCE_FILE"
		echo "${RED}└── ${GREY}Password file moved: ${BLUE}$SOURCE_FILE ${GREY}-> ${GREEN}$TARGET_FILE"
	fi
}
