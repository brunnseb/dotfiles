#!/bin/bash

if nmcli connection show "$1" | grep VPN.VPN-STATE
then
  nmcli connection down "$1"
else
  nmcli connection up "$1"
fi
