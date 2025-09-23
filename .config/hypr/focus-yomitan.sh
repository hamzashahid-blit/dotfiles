#!/usr/bin/env bash

running=$(hyprctl -j clients | jq -r '.[] | select(.class == "LibreWolf") | .workspace.id')

echo $running
if [[ $running != "" ]]; then
    hyprctl dispatch workspace $running
fi
