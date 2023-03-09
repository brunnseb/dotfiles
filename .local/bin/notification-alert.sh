#!/bin/bash

dbus-monitor --profile "type=method_call,interface=org.freedesktop.Notifications,member=Notify" |
  while ((i++));read -r line; do
    if [ $i -gt 4 ]
    then
      paplay /usr/share/sounds/freedesktop/stereo/message.oga
    fi
  done
