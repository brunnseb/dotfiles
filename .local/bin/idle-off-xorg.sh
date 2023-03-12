#!/usr/bin/env bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

# Run xidlehook
xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --detect-sleep \
  --timer 300 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .1' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  --timer 60 \
    'betterlockscreen -l dimblur' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  --timer 600 \
    'systemctl suspend' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1'
