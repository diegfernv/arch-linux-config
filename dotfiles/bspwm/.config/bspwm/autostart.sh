#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

## General --------------------------------------------------------------------#

## Bspwm config directory
BSPDIR="$HOME/.config/bspwm"

## Polybar directory
POLYBARDIR="$HOME/.config/polybar"
STYLE="rosemary"

## Dunst config directory
DUNSTDIR="$HOME/.config/dunst"

## Export bspwm/dir dir to PATH
export PATH="${PATH}:$BSPDIR/scripts"

## Configurations -------------------------------------------------------------#

## Keyboard Layout ##

#change your keyboard if you need it
#setxkbmap -layout be

keybLayout=$(setxkbmap -v | awk -F "+" '/symbols/ {print $2}')


if [ $keybLayout = "be" ]; then
  run sxhkd -c $BSPDIR/sxhkd/sxhkdrc-azerty &
else
  run sxhkd -c $BSPDIR/sxhkd/sxhkdrc &
fi

xsetroot -cursor_name left_ptr &

## Startup programs ------------------------------------------------------------#

#processes=("launch.sh" "picom" "dunst" "easyeffects" "conky" "nm-applet" "volumeicon" "polkit-gnome-authentication-agent-1")

#for process in "${processes[@]}"; do
#    killall -q "$process"
#done

$POLYBARDIR/$STYLE/launch.sh &
picom --config $BSPDIR/picom.conf &
dunst -config $DUNSTDIR/dunstrc &
nohup flatpak run com.github.wwmm.easyeffects --gapplication-service &
conky -c $BSPDIR/system-overview &
run nm-applet &
#run pamac-tray &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
run volumeicon &
dex $HOME/.config/autostart/arcolinux-welcome-app.desktop
