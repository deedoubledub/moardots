#!/bin/sh
echo "setting layout"
xrandr --output DVI-I-0 --off --output DVI-I-1 --off --output HDMI-0 --off --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-4 --primary --mode 2560x1440 --pos 0x1440 --rotate normal --output DP-5 --off
