#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/rosemary"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
if [[ $HOSTNAME == rosemary-desktop ]]; then
    polybar -q top-1 -c "$DIR"/config.ini &
    polybar -q bottom-1 -c "$DIR"/config.ini &
    polybar -q top-2 -c "$DIR"/config.ini &
    polybar -q bottom-2 -c "$DIR"/config.ini &
else
    polybar -q default-top -c "$DIR"/config.ini &
    polybar -q deafult-bottom -c "$DIR"/config.ini &
fi
