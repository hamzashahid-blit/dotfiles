#!/bin/env sh
wallfile="$(find ~/pix/walls -type f \( -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.png' \) | shuf -n1)"
#swww img "$wallfile" --transition-step 4 --transition-fps 60
hyprctl hyprpaper preload "$wallfile"
hyprctl hyprpaper wallpaper "HDMI-A-2,$wallfile"
