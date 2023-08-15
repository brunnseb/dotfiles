#!/bin/bash

current_layout=$(hyprctl getoption general:layout | grep str: | awk '{print $2}') 
echo "Current layout" "$current_layout"

if [ "$current_layout" = '"master"' ]
then
  echo "Change Layout to dwindle"
  hyprctl keyword general:layout dwindle
else
  echo "Change Layout to master"
  hyprctl keyword general:layout master
  hyprctl dispatch layoutmsg swapwithmaster
fi
