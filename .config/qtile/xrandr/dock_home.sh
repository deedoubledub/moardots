#!/usr/bin/env bash

xrandr \
  -d :0 \
  --output eDP-1 --mode 2256x1504 --pos 2560x1376 \
  --output DP-1 --primary --mode 2560x1440 --pos 0x1440 \
  --output DP-2-2-1 --mode 2560x1440 --pos 0x0
