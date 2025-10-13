#!/usr/bin/env bash

if [[ "$(hyprctl monitors -j | jq length)" -ge 2 ]]; then
  hyprctl keyword monitor "eDP-1,disable"
fi
