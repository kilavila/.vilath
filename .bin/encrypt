#!/bin/bash

function vps_encrypt {
	DIR="$1"
	FILE="$2"
	GPG_ID=$(head -n 1 "$DIR/.vps_gpg_id")

	gpg -q --yes -e -r "$GPG_ID" "$DIR/$FILE"
	shred --remove "$DIR/$FILE"
}
