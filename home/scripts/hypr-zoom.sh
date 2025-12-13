#!/usr/bin/env bash

case "$1" in
	up)
		hyprctl -q keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"
		;;
	down)
		hyprctl -q keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"
		;;
esac
