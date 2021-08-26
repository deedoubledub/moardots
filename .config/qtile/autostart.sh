#!/usr/bin/env bash

# set xrandr screen layout, link layout to the desired layout script
~/.config/qtile/xrandr/layout

# random wallpaper
feh --bg-fill ~/.local/share/wallpaper/$(ls ~/.local/share/wallpaper | shuf -n 1)

# start applications
nm-applet &
blueman-applet &
dunst &
discord &
