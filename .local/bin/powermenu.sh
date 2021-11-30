#!/usr/bin/env bash

# Options
logout=" Logout"
reboot="累 Reboot"
shutdown=" Shutdown"
options="$logout|$reboot|$shutdown"

action="$(echo "$options" | rofi -sep '|' -dmenu -i -p '' -theme ~/.config/rofi/powermenu.rasi)"

case $action in
  $logout)
    qtile-cmd -o cmd -f shutdown
    ;;
  $reboot)
    systemctl reboot
    ;;
  $shutdown)
    systemctl poweroff
    ;;
esac