#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

TIME=$(osascript -e 'tell application "Flow" to getTime')
PHASE=$(osascript -e 'tell application "Flow" to getPhase')

if [ $PHASE = "Flow" ]; then
	COLOR=$GREEN
elif [ $PHASE = "休憩" ]; then
	COLOR=$ORANGE
fi

sketchybar --set $NAME label="$TIME $PHASE" icon="$POMODORO" icon.color="$COLOR"
