#!/bin/bash

xrandr --output DP-3 --dpi 137
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xrdb /home/brunnseb/.Xresources
# picom --experimental-backends &
picom &
nm-applet --indicator &
# blueman-applet &
auto-rotate-xorg.sh &
avizo-service &
systemctl --user  enable --now ulauncher   
awesome 
