#! /bin/bash
SOURCE=${BASH_SOURCE[0]}
LOC=$(dirname $(realpath  $SOURCE))
CONFIG=$LOC/rc.lua

# Save the current session so persistent won't try to restore some previous session
# sleep enough time so it actually saves to disk
# awesome-client 'require("daemons.system.persistent"):save()'
# sleep 1.5

echo "Started Xephyer on :1"
Xephyr -br -ac -noreset -screen 1920x1080 :1 &
XEPHYER_PID=$!
DISPLAY=:1

echo "Waiting for X Display - $DISPLAY to go live ..."
while ! xset q &>/dev/null; do
sleep 0.1
done
echo "Xephyr live on $DISPLAY PID=$XEPHYER_PID"

echo "Starting awesome on $DISPLAY using: $CONFIG"
echo
awesome -c ~/.config/awesome/rc-debug.lua 
# awesome-client 'screen[1]:fake_resize(0, 0, 960, 1080)'
# awesome-client 'screen.fake_add(960, 0, 960, 1080)'
echo
echo "awesome exitied - killing Xephyer:"
kill $XEPHYER_PID
echo "DONE"
