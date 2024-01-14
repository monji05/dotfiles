#!/bin/bash

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [[ $MIC_VOLUME -eq 0 ]]; then
	osascript -e 'set volume input volume 25'
	sketchybar -m --set mic icon=􀊱 icon.color="$GREEN"
elif [[ $MIC_VOLUME -gt 0 ]]; then
	osascript -e 'set volume input volume 0'
	sketchybar -m --set mic icon=􀊲 icon.color="$RED"
fi
