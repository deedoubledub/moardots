#!/usr/bin/env bash

# set xrandr layout
if lsusb | grep -q 17ef:1010; then
  # autoselect docked layout when docked
  ~/.config/qtile/xrandr/docked.sh
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
feh --bg-fill ~/.local/share/wallpaper/$(ls ~/.local/share/wallpaper | shuf -n 1)

# start applications
nm-applet &
blueman-applet &
dunst &
discord &
