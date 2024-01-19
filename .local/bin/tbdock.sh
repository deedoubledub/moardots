#!/usr/bin/env bash

user=dwagner

if [[ "$ACTION" == "add"  ]]; then
  # dock
  logger -t DOCK "laptop docked"

  if [[ "$DOCK" == "work" ]]; then
    logger -t DOCK "work dock"
    layout=dock_work
  elif [[ "$DOCK" == "home" ]]; then
    logger -t DOCK "home dock"
    layout=dock_home_single_screen
  fi

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
