#!/bin/bash

export CLICOLOR_FORCE=1

dir=$1
param=$2
flag=$3

list() {
	tree "$dir" -I 'LICENSE|README.md|.bin|.git' -C --noreport | sed -E 's/\/home\/.*\/\.vilath.*/Password Store/' | sed -E 's/\.gpg$//'
}

list
