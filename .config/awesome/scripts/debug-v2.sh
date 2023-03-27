#!/bin/sh

Xephyr -br -ac -noreset -screen 2256x1504 :1 &
DISPLAY=:1
eval "$(dbus-launch --sh-syntax --exit-with-session)" # new dbus session
while ! xset q &>/dev/null; do
sleep 0.1
done
awesome -c /home/brunnseb/.config/awesome/scripts/empty.lua &
sleep 1 # waiting for awesome to register in dbus
# awesome-client 'screen[1]:fake_resize(0, 0, 1128, 1504)'
# awesome-client 'screen.fake_add(1128, 0, 1128, 1504)'
sleep 1
awesome-client </home/brunnseb/.config/awesome/rc.lua # loading the config to test
