#!/usr/bin/env bash
# locks the screen via xsecurelock
# suspends dunst notifications while locked

# pause dunst
dunstctl set-paused true

# lock
env XSECURELOCK_PASSWORD_PROMPT=time_hex \
  XSECURELOCK_SHOW_DATETIME=1 \
  XSECURELOCK_BLANK_TIMEOUT=30 \
  XSECURELOCK_BLANK_DPMS_STATE=off \
  XSECURELOCK_FONT='RobotoMono Nerd Font' \
  XSECURELOCK_NO_COMPOSITE=1 \
  xsecurelock

# resume dunst
dunstctl set-paused false

# shuffle wallpaper
~/.local/bin/wallpaper-shuffle
