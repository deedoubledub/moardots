#!/usr/bin/env bash

user=dwagner

if [[ "$ACTION" == "add"  ]]; then
  # dock
  logger -t DOCK "laptop docked"
  layout=framedocked

elif [[ "$ACTION" == "remove" ]]; then
  # undock
  logger -t DOCK "laptop undocked"
  layout=auto

else
  logger -t DOCK "laptop dock state unknown"
  exit 1
fi

# set xrandr layout
/run/wrappers/bin/su $user -c "/home/$user/.config/qtile/xrandr/$layout.sh"