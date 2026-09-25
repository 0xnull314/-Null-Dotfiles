#!/usr/bin/env bash

picom &
dunst &
redshift &
brightnessctl -d intel_backlight set 100%
setxkbmap -option ctrl:nocaps
dash ~/.fehbg &
xrdb merge ~/.Xresources &
sh ~/.local/src/dwm/scripts/audio.sh &
sh ~/.local/src/dwm/scripts/bar.sh &
