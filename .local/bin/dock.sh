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

# set a flag to prevent multiple triggers
touch /tmp/dock_change

sleep 1

if [[ -f /tmp/dock_change ]]; then
  # clear the flag to only run this once
  rm /tmp/dock_change

  # set xrandr layout
  /run/wrappers/bin/su $user -c "/home/$user/.config/qtile/xrandr/$layout.sh"
fi
