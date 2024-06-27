#!/usr/bin/bash

if [[ $(playerctl status 2>&1) != "No players found" ]]; then
    hyprlock --config ~/.config/hypr/musiclock.conf
else
    hyprlock
fi
