#!/bin/bash

function vps_get_file {
	PARAMS="$@"
	VCMD="$1"

	if [[ "$VCMD" == "vps_gen_cmd" ]]; then
		CMD=$(echo "$PARAMS" | sed -E 's/^(.*)?(generate|gen)\s+(.*)$/\3/')
	elif [[ "$VCMD" == "vps_edit_cmd" ]]; then
		CMD=$(echo "$PARAMS" | sed -E 's/^(.*)?(edit)\s+(.*)$/\3/')
	elif [[ "$VCMD" == "vps_view_cmd" ]]; then
		CMD=$(echo "$PARAMS" | sed -E 's/^(.*)?(view|cat)\s+(.*)$/\3/')
	elif [[ "$VCMD" == "vps_qr_cmd" ]]; then
		CMD=$(echo "$PARAMS" | sed -E 's/^(.*)?(qr)\s+(.*)$/\3/')
	elif [[ "$VCMD" == "vps_copy_cmd" ]]; then
		CMD=$(echo "$PARAMS" | sed -E 's/^(.*)?(copy|cp)\s+(.*)$/\3/')
		TARGET_FILE_REQUIRED=true
	elif [[ "$VCMD" == "vps_move_cmd" ]]; then
		CMD=$(echo "$PARAMS" | sed -E 's/^(.*)?(move|mv)\s+(.*)$/\3/')
		TARGET_FILE_REQUIRED=true
	elif [[ "$VCMD" == "vps_remove_cmd" ]]; then
		CMD=$(echo "$PARAMS" | sed -E 's/^(.*)?(remove|rm)\s+(.*)$/\3/')
	fi

	if [[ "$TARGET_FILE_REQUIRED" ]]; then
		SOURCE=$(echo "$CMD" | awk '{print $1}')
		TARGET=$(echo "$CMD" | awk '{print $2}')
		echo "$SOURCE $TARGET"
	else
		SOURCE=$(echo "$CMD" | awk '{print $1}')
		echo "$SOURCE"
	fi
}
