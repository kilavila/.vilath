#!/bin/bash

function vps_decrypt {
	DIR="$1"
	FILE="$2"

	CONTENT=$(gpg -d -q "$DIR/$FILE.gpg")
	echo "$CONTENT"
}
