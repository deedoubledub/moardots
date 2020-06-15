#!/bin/bash

# random wallpaper
feh --bg-fill ~/.local/share/wallpaper/$(ls ~/.local/share/wallpaper | shuf -n 1)
