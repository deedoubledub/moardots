#!/usr/bin/env bash

# activate all connected displays
xrandr --auto

# find connected tv, i.e. the output that is *not* eDP-1
OUTPUT=$(xrandr --listmonitors | grep -v eDP-1 | tail -n 1 | tr -s ' ' | cut -d ' ' -f 5)

# set that output as a 1920x1080 screen above the laptop screen
xrandr \
  -d :0 \
  --output eDP-1 --mode 2256x1504 --pos 0x1080 \
  --output $OUTPUT --mode 1920x1080 --pos 0x0
