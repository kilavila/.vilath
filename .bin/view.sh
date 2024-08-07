#!/bin/bash

function vps_view {
	IS_LOCKED="$1"
	DIR="$2"
	FILE="$3"

	if [[ "$IS_LOCKED" ]]; then
		INDENT_COLOR=${GREEN}
	else
		INDENT_COLOR=${RED}
		echo "${INDENT_COLOR}┬"
	fi

	CONTENT=$(vps_decrypt "$DIR" "$FILE")
	PASSWORD=$(echo "$CONTENT" | head -n 1)
	PARSED_CONTENT=$(echo "$CONTENT" | tail +2)

	# TODO Mask password, add -a and -c flag
	echo "${INDENT_COLOR}└── ${DARK_GREY}$PASSWORD"

	if [[ -n "$PARSED_CONTENT" ]]; then
		echo ""

		while IFS= read -r LINE; do
				if [[ -n "$LINE" ]]; then
				LABEL=$(echo "$LINE" | sed -E 's/^(\w+)\:\s.*$/\1/')
				VALUE=$(echo "$LINE" | sed -E 's/^\w+\:\s(.*)$/\1/')
				echo "    ${BLUE}$LABEL: ${YELLOW}$VALUE"
			fi
		done <<< "$PARSED_CONTENT"
	fi
}
