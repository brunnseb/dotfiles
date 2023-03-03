#!/bin/bash

#uses the values output by monitor-sensor to call the rotate function
function rotate_ms {
    case $1 in
        "normal")
            rotate 0
            ;;
        "right-up")
            rotate 3
            ;;
        "bottom-up")
            rotate 2
            ;;
        "left-up")
             rotate 1
            ;;
    esac
}

function rotate {
    #Rotate the screen
    hyprctl keyword monitor eDP-1,transform,"$1"
    #Rotate touchscreen input finger
    hyprctl keyword device:wacom-hid-495f-finger:transform "$1" 
    #Rotate touchscreen input pen 
    hyprctl keyword device:wacom-hid-495f-pen:transform "$1" 
    #Rotate touchscreen-gestures
    killall lisgd
    touchscreen-gestures.sh  &
}

while IFS='$\n' read -r line; do
    rotation="$(echo "$line" | sed -En "s/^.*orientation changed: (.*)/\1/p")"
    [[ -n  $rotation  ]] && rotate_ms "$rotation"
done < <(stdbuf -oL monitor-sensor)
