#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
LABEL="${PERCENTAGE}%"
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
	exit 0
fi

COLOR=$GREEN
case ${PERCENTAGE} in
9[0-9] | 100)
	ICON="􀛨"
	COLOR=$GREEN
	;;
[6-8][0-9])
	ICON="􀺸"
	COLOR=$GREEN
	;;
[3-5][0-9])
	ICON="􀺶"
	COLOR=0xfff97716
	;;
[1-2][0-9])
	ICON="􀛩"
	COLOR=$RED
	;;
*)
	ICON="􀛪"
	LABEL=""
	;;
esac

if [[ $CHARGING != "" ]]; then
	ICON="􀢋"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set $NAME icon="$ICON" icon.color="$COLOR" label="$LABEL"
