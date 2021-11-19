#!/usr/bin/env bash

# Options
logout="\uF842"
reboot="\uFC07"
shutdown="\uF011"
options="$logout\n$reboot\n$shutdown"

action="$(echo -e "$options" | rofi -dmenu -i -p '' -theme ~/.config/rofi/powermenu.rasi)"

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
