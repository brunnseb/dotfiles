#!/bin/bash

dbus-monitor --profile "type=method_call,interface=org.freedesktop.Notifications,member=Notify" |
  while read -r line; do
    paplay /usr/share/sounds/freedesktop/stereo/message.oga
  done
