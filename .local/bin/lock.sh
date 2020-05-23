#!/bin/bash
# locks the screen via i3lock-color
# suspends dunst notifications while locked

# pause dunst
killall -SIGUSR1 dunst

# lock
i3lock-color                \
  --nofork                  \
  --screen 0                \
  --blur 7                  \
  --radius=150              \
  --clock                   \
  --timestr="%-I:%M %p"     \
  --datestr="%A, %B %-d %Y" \

# resume dunst
killall -SIGUSR2 dunst
