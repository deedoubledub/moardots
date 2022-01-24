#!/usr/bin/env bash

# set xrandr layout
if lsusb | grep -q 17ef:1010; then
  # autoselect docked layout when docked (thinkpad)
  ~/.config/qtile/xrandr/docked.sh
elif lsusb | grep -q 05e3:0620; then
  # autoselect framedocked layout when docked (framework)
  ~/.config/qtile/xrandr/framedocked.sh
else
  if [ -f ~/.config/qtile/xrandr/layout ]; then
    # use defined layout when not docked if it exists
    ~/.config/qtile/xrandr/layout
  else
    # use auto as a fallback
    ~/.config/qtile/xrandr/auto.sh
  fi
fi

# random wallpaper
~/.local/bin/wallpaper-shuffle

# start applications
nm-applet &
blueman-applet &
dunst &
discord &
