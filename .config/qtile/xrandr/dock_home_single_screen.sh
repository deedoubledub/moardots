#!/usr/bin/env bash

xrandr \
  -d :0 \
  --fb 5328x1728 \
  --output eDP-1 --mode 2256x1504 --pos 3072x1952 \
  --output DP-1-2-1 --primary --mode 2560x1440 --pos 0x1728 --scale 1.2x1.2
