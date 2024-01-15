#!/bin/bash

source "$CONFIG_DIR/icons.sh"

sketchybar -m --add item vpn right \
	--set vpn icon="$VPN_ICON" \
	script="$PLUGIN_DIR/vpn.sh" \
	update_freq=5
