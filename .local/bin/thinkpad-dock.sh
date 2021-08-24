#!/usr/bin/env bash

# wait for the dock change
sleep 1

username=dwagner

if [[ "$ACTION" == "add"  ]]; then
  DOCKED=1
  logger -t DOCK "Dock: laptop docked"
elif [[ "$ACTION" == "remove" ]]; then
  DOCKED=0
  logger -t DOCK "Dock: laptop undocked"
else
  logger -t DOCK "Dock: laptop dock unknown"
  exit 1
fi

function undock {
  logger -t DOCK "Switching to local laptop display"

  export DISPLAY=$1
  su $username -c '/home/dwagner/.config/qtile/xrandr/laptop.sh'
}

function dock {
  logger -t DOCK "Switching to external dock display"

  export DISPLAY=$1
  su $username -c '/home/dwagner/.config/qtile/xrandr/docked.sh'
}

case "$DOCKED" in
  "0")
    undock :0 ;;
  "1")
  dock :0 ;;
esac
