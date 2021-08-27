#!/usr/bin/env bash

# set xrandr layout
if lsusb | grep -q 17ef:1010; then
  # autoselect docked layout when docked
  /home/dwagner/.config/qtile/xrandr/docked.sh
else
  # use defined layout when not docked
  /home/dwagner/.config/qtile/xrandr/layout
fi

# random wallpaper
feh --bg-fill ~/.local/share/wallpaper/$(ls ~/.local/share/wallpaper | shuf -n 1)

# start applications
nm-applet &
blueman-applet &
dunst &
discord &
