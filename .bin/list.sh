#!/bin/bash

export CLICOLOR_FORCE=1

param=$1
flag=$2

username=$(whoami)

list() {
	tree "/home/$username/.vilath" -C --noreport | sed -E 's/\/home\/.*\/\.vilath.*/Password Store/' | sed -E 's/\.gpg$//'
}

list
