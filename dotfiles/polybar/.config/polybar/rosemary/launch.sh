#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/rosemary"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
if [[ $HOSTNAME == rosemary-desktop ]]; then
    polybar -q primary-screen -c "$DIR"/config.ini &
    polybar -q secondary-screen -c "$DIR"/config.ini &
else
    polybar -q default-top -c "$DIR"/config.ini &
    polybar -q default-bottom -c "$DIR"/config.ini &
fi
