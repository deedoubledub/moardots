#!/bin/bash

oc=$(pgrep openconnect)
tun=$(ip addr | awk '/inet/ && /tun0/')

if [[ $oc == '' ]] || [[ $tun == '' ]]; then
  echo VPN down
elif [[ $oc != '' ]] && [[ $tun != '' ]]; then
  echo VPN up
else
  echo VPN UNKNOWN
fi
