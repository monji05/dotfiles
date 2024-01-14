#!/bin/bash

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [[ $MIC_VOLUME -eq 0 ]]; then
	sketchybar -m --set mic icon=􀊲 icon.color=$RED
elif [[ $MIC_VOLUME -gt 0 ]]; then
	sketchybar -m --set mic icon=􀊱 icon.color=$GREEN
fi
