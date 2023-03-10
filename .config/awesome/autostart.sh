#!/bin/bash

/home/brunnseb/.screenlayout/home_office.sh
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
