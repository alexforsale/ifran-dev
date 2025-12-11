#!/usr/bin/env bash
# original script from https://wiki.archlinux.org/index.php/Dunst
# <alexforsale@yahoo.com>
# changeVolume

msgTag="myvolume"
pamixer="$(command -v pamixer)"
dunstify="$(command -v dunstify)"
canberra_gtk_play="$(command -v canberra-gtk-play)"

# args = -i % or -d %
"${pamixer}" "${@}" > /dev/null
volume="$(${pamixer} --get-volume)"
mute="$(${pamixer} --get-mute)"
if [ "${mute}" == "true" ]; then
    icon="audio-volume-muted"
    symbol=""
elif [ "${mute}" == "false" ] &&
         [ "${volume}" -gt 0 ] &&
         [ "${volume}" -le 25 ]; then
    icon="audio-volume-low"
    symbol=""
elif [ "${mute}" == "false" ] &&
         [ "${volume}" -gt 25 ] &&
         [ "${volume}" -le 75 ]; then
    icon="audio-volume-medium"
    symbol=""
elif [ "${mute}" == "false" ] &&
         [ "${volume}" -gt 75 ]; then
    icon="audio-volume-high"
    symbol=""
fi

if [[ $volume == 0 || "$mute" == "true" ]]; then
    "${dunstify}" -a "changeVolume" -u low -i "${icon}" -h string:x-dunst-stack-tag:$msgTag "${symbol} Volume muted"
else
    "${dunstify}" -a "changeVolume" -u low -i "${icon}" -h string:x-dunst-stack-tag:$msgTag \
    -h int:value:"$volume" "${symbol} Volume: ${volume}%"
fi

"${canberra_gtk_play}" -i audio-volume-change -d "changeVolume"
