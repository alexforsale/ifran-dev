#!/usr/bin/env bash
# start|stop screencast

set -o errexit
set -o pipefail

PIDFILE="${HOME}/.local/state/.screenrecord.pid"
OUTFILE="/tmp/out.avi"
FINALFILE="${HOME}/Videos/screen-record-$(date +'%Y-%m-%d--%H-%M-%S').mp4"
ffmpeg="$(command -v ffmpeg)"
notify_send="$(command -v notify-send)"
xrandr="$(command -v xrandr)"

[[ ! -d $(dirname ${PIDFILE}) ]] && mkdir -p $(dirname ${PIDFILE})
[[ ! -d $(dirname ${FINALFILE}) ]] && mkdir -p $(dirname ${FINALFILE})

# check if this script is already running
if [ -s "${PIDFILE}" ] && [ -d "/proc/$(cat ${PIDFILE})" ]; then

    # send SIG_TERM to screen recorder
    kill $(cat "${PIDFILE}")

    # clear the pidfile
    rm "${PIDFILE}"

    # move the screencast into the user's video directory
    mv "${OUTFILE}" "${FINALFILE}"
      "${notify_send}" -a "i3-screen-record" -t 3000 "saved to ${FINALFILE}"

else
    # screen resolution
    SCREENRES=$(${xrandr} -q --current | grep '*' | awk '{print$1}')

	notify-send -a "i3-screen-record" -t 1000 "Start screen record"
    # write to the pidfile
    echo $$ > "${PIDFILE}" &&

    # let the recording process take over this pid
    exec "${ffmpeg}" \
		-video_size "${SCREENRES}" \
		-f x11grab \
		-i :0.0 \
		-c:v libx264 \
		-preset ultrafast \
		-framerate 30 \
		-vf format=yuv420p "${OUTFILE}"
fi
