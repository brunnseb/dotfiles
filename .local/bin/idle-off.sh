#!/bin/bash

swayidle -w \
	timeout 300 'lock-screen.sh' \
	# timeout 600 'hyprctl dispatch dpms off eDP-1' \
	# 	resume 'hyprctl dispatch dpms on eDP-1' \
	before-sleep 'lock-screen.sh'
