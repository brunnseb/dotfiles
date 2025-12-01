#!/usr/bin/env bash

case "$1" in
close)
  hyprctl keyword monitor "eDP-1, disable"
  # Optional: Shift all workspaces to the external monitor
  # hyprctl keyword monitor "DP-1"
  ;;
open)
  hyprctl keyword monitor "eDP-1, enable"
  # Optional: Shift workspaces back
  # hyprctl keyword monitor "eDP-1"
  ;;
esac
