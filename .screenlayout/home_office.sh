#!/bin/sh
if  xrandr --listmonitors | grep DP-3;  then
  xrandr --output eDP-1 --off --output DP-1 --off --output DP-2 --off --output DP-3 --primary --mode 3840x2160 --pos 0x0 --rotate normal
  xrandr --output DP-3 --dpi 137
fi
