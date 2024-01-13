# Add event
sketchybar -m --add event song_update com.apple.iTunes.playerInfo

# Add Music Item
sketchybar -m --add item music right \
	--set music script="$ITEM_DIR/music.sh" \
	click_script="$ITEM_DIR/music_click.sh" \
	label.padding_right=10 \
	drawing=off \
	--subscribe music song_update
