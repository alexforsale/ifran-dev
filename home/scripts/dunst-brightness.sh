#!/usr/bin/env bash
# original script from https://wiki.archlinux.org/index.php/Dunst
# <alexforsale@yahoo.com>
# changeBrightness

set -o errexit
set -o pipefail

# Arbitrary but unique message tag
msgTag="mybrightness"
brightnessctl="$(command -v brightnessctl)"
awk="$(command -v awk)"
dunstify="$(command -v dunstify)"
canberra_gtk_play="$(command -v canberra-gtk-play)"

brightnessctl set "${@}" > /dev/null

max="$(${brightnessctl} max)"
current="$(${brightnessctl} get)"
percentage="$(${awk} -v current=${current} -v max=${max} 'BEGIN { print ( (current / max) * 100 )}')"
percentage="${percentage%.*}"

# Show the brightness notification
"${dunstify}" -a "changeBrightness" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
    -h int:value:"${percentage}" " Brightness: ${percentage}%"

# Play the brightness changed sound
"${canberra_gtk_play}" -i audio-volume-change -d "changeVolume"
