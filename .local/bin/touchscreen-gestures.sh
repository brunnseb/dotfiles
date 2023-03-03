#!/bin/bash

# transform=hyprctl monitors | awk '/transform/ {print $2}'


lisgd -d '/dev/input/by-path/pci-0000:00:15.0-platform-i2c_designware.0-event'\
  -g "1,UD,B,*,R,kill -s USR1 $(pidof wvkbd-mobintl)" \
  -g "1,DU,B,*,R,kill -s USR2 $(pidof wvkbd-mobintl)" \
  -g "2,UD,*,*,R,hyprctl dispatch workspace -1" \
  -g "2,DU,*,*,R,hyprctl dispatch workspace +1" \
  -g "3,DU,*,*,R,hyprctl dispatch movetoworkspace -1" \
  -g "3,UD,*,*,R,hyprctl dispatch movetoworkspace +1" \
  -g "4,UD,*,*,R,hyprctl dispatch killactive" \
  -g "4,DU,*,*,R,nwggrid -client" 
