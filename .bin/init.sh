#!/bin/bash

gpg_id=$1

username=$(whoami)

init() {
	if [[ -e "/home/$username/.vilath/.gpg_id" ]]; then
		echo "Vilath has already been initialized!"
		echo "Warning! This action will encrypt all your passwords with the new GnuPG ID!"
		read -p "Would you like to update the GnuPG ID? y/N: " overwrite

		if [[ "$overwrite" == "y" ]]; then
			echo "Decrypting passwords"
			# decrypt ALL password files
			echo "Updating GnuPG ID file"
			echo "$gpg_id" > "/home/$username/.vilath/.gpg_id"
			echo "Encrypting passwords with new GnuPG ID"
			# encrypt ALL password files with new ID
		fi
	else
		echo "Initializing vilath password manager"
		echo "Creating GnuPG ID file: $dir/.gpg_id"
		echo "$gpg_id" > "/home/$username/.vilath/.gpg_id"
	fi
}

init
