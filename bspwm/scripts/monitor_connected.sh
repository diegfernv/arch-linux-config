#!/bin/bash
export DISPLAY=:0
export XAUTORITY=/home/diego/.Xauthority

if [[ $HOSTNAME == rosemary-desktop ]]; then
	if xrandr | grep "HDMI-0 connected"; then
		autorandr desktop-kamvas;
	elif xrandr | grep "DP-2 connected"; then
		autorandr desktop;
	else
		xrandr --output DP-0 --auto --primary
	fi
else
	xrandr --output "$intern" --primary --auto --output "$extern" \
		--right-of "$intern" --auto;
fi
