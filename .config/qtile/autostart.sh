#!/usr/bin/env bash

# set xrandr layout
if lsusb | grep -q 05e3:0620; then
  # autoselect framedocked layout when docked
  ~/.config/qtile/xrandr/docked.sh
else
  # use auto as a fallback
  ~/.config/qtile/xrandr/auto.sh
fi

# random wallpaper
~/.local/bin/wallpaper-shuffle

# start applications
nm-applet &
blueman-applet &
dunst &
discord &
