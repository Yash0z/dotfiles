#!/usr/bin/env sh

# Check if wlogout is already running
if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

# Launch wlogout with -b 5 option
wlogout -b 5 -T 200 -B 200
