#!/bin/bash

source "$CONFIG_DIR/icons.sh" # Loads all defined colors

sketchybar --add item cpu right \
	--set cpu update_freq=2 \
	icon=$CPU \
	script="$PLUGIN_DIR/cpu.sh"
