#!/bin/bash

USER=$(whoami)
DIR="/home/$USER/.vilath"

function vps_cmd_handler {
	PARAMS="$@"

	CHATTR=$(lsattr -dR "$DIR" | awk '{print $1}')
	if [[ "$CHATTR" == *"i"* ]]; then
		IS_LOCKED=true;
	fi

	if [[ "$PARAMS" > 0 ]]; then
		for PARAM in "$@"; do
			if [[ "$PARAM" == "unlock" ]]; then UNLOCK=true;
			elif [[ "$PARAM" == "lock" ]]; then LOCK=true;
			elif [[ "$PARAM" == "initialize" || "$PARAM" == "init" ]]; then INITIALIZE=true;
			elif [[ "$PARAM" == "generate" || "$PARAM" == "gen" ]]; then GENERATE=true;
			elif [[ "$PARAM" == "edit" ]]; then EDIT=true;
			elif [[ "$PARAM" == "view" || "$PARAM" == "cat" ]]; then VIEW=true;
			elif [[ "$PARAM" == "list" || "$PARAM" == "ls" ]]; then LIST=true;
			elif [[ "$PARAM" == "search" || "$PARAM" == "find" || "$PARAM" == "fd" ]]; then FIND=true;
			elif [[ "$PARAM" == "qr" ]]; then QR=true;
			elif [[ "$PARAM" == "copy" || "$PARAM" == "cp" ]]; then COPY=true;
			elif [[ "$PARAM" == "move" || "$PARAM" == "mv" ]]; then MOVE=true;
			elif [[ "$PARAM" == "remove" || "$PARAM" == "rm" ]]; then REMOVE=true;
			elif [[ "$PARAM" == "git" ]]; then GIT=true;
			fi
		done
	else LIST=true;
	fi

	: '
	╭──────╮
	│ Lock │
	├──────╯
	'
	if [[ "$UNLOCK" ]]; then
		sudo chattr -i -R "$DIR"
		echo "${RED}VPS Unlocked${NC}"
		return 0
	fi
	if [[ "$LOCK" ]]; then
		sudo chattr +i -R "$DIR"
		echo "${GREEN}VPS Locked${NC}"
		return 0
	fi

	: '
	╭────────╮
	│ Header │
	├────────╯
	'
	if [[ "$IS_LOCKED" ]]; then
		echo " ${GREEN}╭────────────────────────────╮"
		echo " │ ${GREY}┏┓  ${DARK_GREY}.vilath   ${GREY}┓  ┏┓        ${GREEN}│"
		echo " │ ${GREY}┃┃┏┓┏┏┓┏┏┏┓┏┓┏┫  ┗┓╋┏┓┏┓┏┓ ${GREEN}│"
		echo " │ ${GREY}┣┛┗┻┛┛┗┻┛┗┛┛ ┗┻  ┗┛┗┗┛┛ ┗  ${GREEN}│"
		echo "┌┴────────────────────────────┴┐"
		echo "│${NC}"
	else
		echo " ${RED}╭────────────────────────────╮"
		echo " │ ${GREY}┏┓  ${DARK_GREY}.vilath   ${GREY}┓  ┏┓        ${RED}│"
		echo "   ${GREY}┃┃┏┓┏┏┓┏┏┏┓┏┓┏┫  ┗┓╋┏┓┏┓┏┓ ${RED}│"
		echo "   ${GREY}┣┛┗┻┛┛┗┻┛┗┛┛ ┗┻  ┗┛┗┗┛┛ ┗  ${RED}│"
		echo "┌─────────────────────────────┴┐"
		echo "┴${NC}"
	fi

	: '
	╭────────────╮
	│ Initialize │
	├────────────╯
	'
	if [[ "$INITIALIZE" ]]; then
		if [[ "$IS_LOCKED" ]]; then vps_locked_error; return 0; fi

		GPG_ID=$(echo "$PARAMS" | sed -E 's/^.*(initialize|init)\s+([a-zA-Z0-9\-\_\.\@]+).*$/\2/')
		vps_initialize "$DIR" "$GPG_ID"
	fi

	: '
	╭──────────╮
	│ Generate │
	├──────────╯
	'
	if [[ "$GENERATE" ]]; then
		if [[ "$IS_LOCKED" ]]; then vps_locked_error; return 0; fi

		SOURCE=$(vps_get_file "vps_gen_cmd" "$PARAMS")
		vps_generate "$DIR" "$SOURCE"
	fi

	: '
	╭──────╮
	│ Edit │
	├──────╯
	'
	if [[ "$EDIT" ]]; then
		if [[ "$IS_LOCKED" ]]; then vps_locked_error; return 0; fi

		SOURCE=$(vps_get_file "vps_edit_cmd" "$PARAMS")
		vps_edit "$DIR" "$SOURCE"
	fi

	: '
	╭──────╮
	│ View │
	├──────╯
	'
	if [[ "$VIEW" ]]; then
		SOURCE=$(vps_get_file "vps_view_cmd" "$PARAMS")
		vps_view "$IS_LOCKED" "$DIR" "$SOURCE"
	fi

	: '
	╭──────╮
	│ Copy │
	├──────╯
	'
	if [[ "$COPY" ]]; then
		if [[ "$IS_LOCKED" ]]; then vps_locked_error; return 0; fi

		SOURCE_TARGET=$(vps_get_file "vps_copy_cmd" "$PARAMS")
		SOURCE_FILE=$(echo "$SOURCE_TARGET" | awk '{print $1}')
		TARGET_FILE=$(echo "$SOURCE_TARGET" | awk '{print $2}')
		vps_copy "$DIR" "$SOURCE_FILE" "$TARGET_FILE"
	fi

	: '
	╭──────╮
	│ Move │
	├──────╯
	'
	if [[ "$MOVE" ]]; then
		if [[ "$IS_LOCKED" ]]; then vps_locked_error; return 0; fi

		SOURCE_TARGET=$(vps_get_file "vps_move_cmd" "$PARAMS")
		SOURCE_FILE=$(echo "$SOURCE_TARGET" | awk '{print $1}')
		TARGET_FILE=$(echo "$SOURCE_TARGET" | awk '{print $2}')
		vps_move "$DIR" "$SOURCE_FILE" "$TARGET_FILE"
	fi

	: '
	╭────────╮
	│ Remove │
	├────────╯
	'
	if [[ "$REMOVE" ]]; then
		if [[ "$IS_LOCKED" ]]; then vps_locked_error; return 0; fi

		SOURCE=$(vps_get_file "vps_remove_cmd" "$PARAMS")
		vps_remove "$DIR" "$SOURCE"
	fi

	: '
	╭──────╮
	│ List │
	├──────╯
	'
	if [[ "$LIST" ]]; then
		if ! [[ "$IS_LOCKED" ]]; then
			echo "${RED}┬${NC}"
		fi
		vps_list "$IS_LOCKED"
	fi

	: '
	╭──────╮
	│ Find │
	├──────╯
	'
	if [[ "$FIND" ]]; then
		if ! [[ "$IS_LOCKED" ]]; then
			echo "${RED}┬${NC}"
		fi

		QUERY=$(echo "$PARAMS" | awk '{print $2}')
		vps_find "$IS_LOCKED" "$QUERY"
	fi

	: '
	╭────╮
	│ QR │
	├────╯
	'
	if [[ "$QR" ]]; then
		if ! [[ "$IS_LOCKED" ]]; then
			echo "${RED}┬${NC}"
			INDENT_COLOR=${RED}
		else
			INDENT_COLOR=${GREEN}
		fi


		SOURCE=$(vps_get_file "vps_qr_cmd" "$PARAMS")
		echo "${INDENT_COLOR}└── ${GREY}Generating QR-Code: ${YELLOW}$SOURCE"
		CONTENT=$(vps_decrypt "$DIR" "$SOURCE")
		PASSWORD=$(echo "$CONTENT" | head -n 1)

		echo "${BLUE}"
		echo "$PASSWORD" | qrencode -t utf8i -s 1 -m 2
	fi

	: '
	╭─────╮
	│ Git │
	├─────╯
	'
	if [[ "$GIT" ]]; then
		if [[ "$IS_LOCKED" ]]; then vps_locked_error; return 0; fi

		echo "${BLUE}Work in progress..."
		echo "Git options"
	fi

	echo "${NC}"
}
