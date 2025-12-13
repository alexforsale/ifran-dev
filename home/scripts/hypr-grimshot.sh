#!/usr/bin/env bash

DATE="$(echo ~/Pictures/Screenshots/Screenshot-$(date +'%Y%m%d_%H%M%S').png)"

case "${1}" in
"active")
	grimshot --notify savecopy active ${DATE}
	;;
"screen")
	grimshot --notify savecopy screen ${DATE}
	;;
"area")
	grimshot --notify savecopy area ${DATE}
esac
