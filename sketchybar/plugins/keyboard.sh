#!/bin/bash

# this is jank and ugly, I know
LAYOUT="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -c 33- | rev | cut -c 2- | rev)"

# specify short layouts individually.
case "$LAYOUT" in
"ABC") SHORT_LAYOUT="US" ;;
*) SHORT_LAYOUT="あ" ;;
esac

sketchybar --set keyboard update_freq=5 label="$SHORT_LAYOUT"
