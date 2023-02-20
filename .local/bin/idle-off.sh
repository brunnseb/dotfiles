#!/bin/bash

swayidle -w \
	before-sleep 'lock-screen.sh' \
	timeout 300 'lock-screen.sh' \
	timeout 600 'systemctl suspend' \
