#!/bin/bash

function vps_create_new_password {
	DIR="$1"
	FILE="$2"
	PASSWORD=$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+-={}:<>?[]|~')

	echo "$PASSWORD" > "$DIR/$FILE"
	vps_encrypt "$DIR" "$FILE"
	echo "${RED}└── ${GREY}Password file generated: ${GREEN}$FILE"
}

function vps_generate {
	DIR="$1"
	FILE="$2"

	echo "${RED}┬"

	if [[ -e "$DIR/$FILE.gpg" ]]; then

		echo "│   Password file already exist!"
		read -p "${RED}│   ${GREY}Would you like to ${YELLOW}overwrite the existing file${GREY}? [y/N] " CONFIRM
		echo "│"

		if [[ "$CONFIRM" == "Y" || "$CONFIRM" == "y" ]]; then
			vps_create_new_password "$DIR" "$FILE"
		else
			echo "${RED}└── ${GREY}Aborted"
		fi

	else

		if [[ "$FILE" =~ \/ ]]; then
			DIRECTORIES=$(echo "$FILE" | sed -E 's/^(.*)\/.*$/\1/')

			if [[ -n "$DIRECTORIES" && ! -d "$DIR/$DIRECTORIES" ]]; then
				mkdir -p "$DIR/$DIRECTORIES"
			fi
		fi

		vps_create_new_password "$DIR" "$FILE"
	fi
}
