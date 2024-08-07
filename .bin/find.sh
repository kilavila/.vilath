#!/bin/bash

function vps_find {
	IS_LOCKED="$1"
	QUERY="$2"

	if [[ "$IS_LOCKED" ]]; then
		INDENT_COLOR=${GREEN}
	else
		INDENT_COLOR=${RED}
	fi

	CONTENT=$(tree "$DIR" -I 'LICENSE|README.md|.bin|.git*|.vps_*' -P "*$QUERY*.gpg" --prune --noreport | tail +2)

	if ! [[ -n "$CONTENT" ]]; then
		echo "${INDENT_COLOR}└── ${GREY}No match found for: ${YELLOW}$QUERY${NC}"
	else
		while IFS= read -r LINE; do
			INDENT=$(echo "$LINE" | sed -E 's/^(.*)\s[a-zA-Z0-9\-\_\.].*$/\1/')
			ITEM=$(echo "$LINE" | sed -E 's/^[^a-zA-Z0-9\-\_\.]*(.*)$/\1/')

			if [[ "$ITEM" == *".gpg" ]]; then
				FILE=$(echo "$ITEM" | sed -E 's/^(.*).gpg/\1/')
				echo "${INDENT_COLOR}$INDENT ${YELLOW}$FILE"
			else
				echo "${INDENT_COLOR}$INDENT ${BLUE}$ITEM"
			fi
		done <<< "$CONTENT"
	fi
}

# README
# ------------------------
# This function returns a simplified list of password files
# without directories and hidden files.
# To extend the password store, run this function and pipe the result
# into a different application like dmenu, rofi or fzf.
function vps_find_simple {
	QUERY="$1"
	FILES=$(tree -i -f -P "*$QUERY*.gpg" --prune | ack .gpg | sed -E 's/^\.\/(.*)\.gpg$/\1/')
	echo "$FILES"
}

# Same as the function above, but this will include hidden files as well.
function vps_find_all_simple {
	QUERY="$1"
	ALL_FILES=$(tree -i -f -a -P "*$QUERY*.gpg" --prune | ack .gpg | sed -E 's/^\.\/(.*)\.gpg$/\1/')
	echo "$ALL_FILES"
}
