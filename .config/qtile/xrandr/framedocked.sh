#!/usr/bin/env bash

## 1.5x scaling
xrandr \
  -d :0 \
  --fb 5136x3240 \
  --output eDP-1 --mode 2256x1504 --pos 2880x1736 \
  --output DP-4 --mode 1920x1080 --pos 0x0 --scale 1.5x1.5 \
  --output DP-3-1 --primary --mode 1920x1080 --pos 0x1620 --scale 1.5x1.5
