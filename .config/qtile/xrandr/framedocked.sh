#!/usr/bin/env bash

## 1.5x scaling
xrandr \
  -d :0 \
  --fb 5136x3240 \
  --output eDP-1 --mode 2256x1504 --pos 0x1736 \
  --output DP-4 --mode 1920x1080 --pos 2256x0 --scale 1.5x1.5 \
  --output DP-3-1 --primary --mode 1920x1080 --pos 2256x1620 --scale 1.5x1.5

## 2x scaling
# xrandr \
#   -d :0 \
#   --fb 6096x4320 \
#   --output eDP-1 --mode 2256x1504 --pos 0x2816 \
#   --output DP-4 --mode 1920x1080 --pos 2256x0 --scale 2x2 \
#   --output DP-3-1 --primary --mode 1920x1080 --pos 2256x2160 --scale 2x2
