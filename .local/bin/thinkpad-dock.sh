#!/usr/bin/env bash

user=dwagner

if [[ "$ACTION" == "add"  ]]; then
  # dock
  logger -t DOCK "laptop docked"
  layout=docked

elif [[ "$ACTION" == "remove" ]]; then
  # undock
  logger -t DOCK "laptop undocked"
  layout=laptop

else
  logger -t DOCK "laptop dock state unknown"
  exit 1
fi

# set xrandr layout
/run/wrappers/bin/su $user -c "/home/$user/.config/qtile/xrandr/$layout.sh"

# restart qtile
/run/wrappers/bin/su $user -c "qtile-cmd -o cmd -f restart"
