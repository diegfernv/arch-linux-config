#!/bin/bash

default_workspaces(){
    for monitor in `xrandr -q | grep -w 'connected' | cut -d' ' -f1`; do
        bspc monitor "$monitor" -d 1 2 3 4 5 6 7
    done
}

two_monitors_workspaces(){
        INTERNAL_MONITOR="eDP-1"
        EXTERNAL_MONITOR="HDMI-1"
        if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
            bspc monitor "$EXTERNAL_MONITOR" -d 1 2 3 4 5
            bspc monitor "$INTERNAL_MONITOR" -d 6 7 8 9 10
            bspc wm -O "$EXTERNAL_MONITOR" "$INTERNAL_MONITOR"
        else
            bspc monitor "$INTERNAL_MONITOR" -d 1 2 3 4 5 6 7
        fi
}

three_monitors_workspaces(){
    MONITOR_1="DP-0"
    MONITOR_2="DP-2"
    MONITOR_3="HDMI-1"
    bspc monitor "$MONITOR_1" -d 1 2 3 4 5
    bspc monitor "$MONITOR_2" -d 6 7 8 9 10
    bspc monitor "$MONITOR_3" -d 11
    bspc wm -O "$MONITOR_2" "$MONITOR_1" "$MONITOR_3" 
    
}

## General --------------------------------------------------------------------#

## Bspwm config directory
BSPDIR="$HOME/.config/bspwm"

## Polybar directory
POLYBARDIR="$HOME/.config/polybar"
STYLE="rosemary"

## Configurations -------------------------------------------------------------#

## Display ##
autorandr -c && 

if [[ $HOSTNAME == rosemary-desktop ]]; then
    three_monitors_workspaces
else
    two_monitors_workspaces
fi

# Wallpaper
feh --bg-scale $BSPDIR/wallpaper/candy-09.jpg &

