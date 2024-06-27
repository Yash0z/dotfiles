#!/bin/bash


cliphist list | rofi -dmenu -display-columns 2 -config ~/.config/rofi/clipboard/cliphist.rasi | cliphist decode | wl-copy
