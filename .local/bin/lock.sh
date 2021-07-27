#!/usr/bin/env bash
# locks the screen via xsecurelock
# suspends dunst notifications while locked

# pause dunst
killall -SIGUSR1 dunst

# lock
env XSECURELOCK_PASSWORD_PROMPT=time_hex \
  XSECURELOCK_SHOW_DATETIME=1 \
  XSECURELOCK_BLANK_TIMEOUT=30 \
  XSECURELOCK_BLANK_DPMS_STATE=off \
  XSECURELOCK_FONT='RobotoMono Nerd Font' \
  xsecurelock

# resume dunst
killall -SIGUSR2 dunst
