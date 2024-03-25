sketchybar --add item slack right \
	--set slack \
	update_freq=30 \
	script="$PLUGIN_DIR/slack.sh" \
	background.padding_left=15 \
	icon.font.size=21 \
	--subscribe slack system_woke
