#!/bin/bash

source "$CONFIG_DIR/icons.sh"

VPN=$(scutil --nc list | grep Connected | sed -E 's/.*"(.*)".*/\1/')

if [[ $VPN != "" ]]; then
	sketchybar -m --set vpn icon="$VPN_ICON" \
		label="$VPN" \
		drawing=on
else
	sketchybar -m --set vpn drawing=off
fi
