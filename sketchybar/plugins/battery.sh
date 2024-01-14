#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors
source "$CONFIG_DIR/icons.sh"  # Loads all defined colors

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
LABEL="${PERCENTAGE}%"
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
	exit 0
fi

COLOR=$GREEN
case ${PERCENTAGE} in
9[0-9] | 100)
	ICON="$BATTERY_100"
	COLOR=$GREEN
	;;
[6-8][0-9])
	ICON="$BATTERY_100"
	COLOR=$GREEN
	;;
[3-5][0-9])
	ICON="$BATTERY_50"
	COLOR=0xfff97716
	;;
[1-2][0-9])
	ICON="$BATTERY_25"
	COLOR=$RED
	;;
*)
	ICON="$BATTERY_0"
	LABEL=""
	;;
esac

if [[ $CHARGING != "" ]]; then
	ICON="$BATTERY_CHARGING"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set $NAME icon="$ICON" icon.color="$COLOR" label="$LABEL"
