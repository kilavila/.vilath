#!/bin/bash

function vps_locked_error {
	echo "${GREEN}│   ${RED}Unauthorized!"
	echo "${GREEN}└── ${GREY}This action is not allowed while VPS is locked.${NC}"
}
