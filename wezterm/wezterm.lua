-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font = wezterm.font("PlemolJP35 Console NF")
config.font_size = 20.5
config.default_prog = { "/opt/homebrew/bin/fish" }
config.window_background_opacity = 0.9
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false
config.cell_width = 0.95
-- config.line_height = 1.0

-- solarized-osaka night colorscheme
config.colors = {
	-- tokyonight night
	background = "#011423",
	-- tokyonight storm
	-- background = "#1f2335",

	-- solarized-osaka
	-- background = "#00181a",
	background = "#001011",

	-- solarized
	-- background = "#002B36",
	-- background = "#01222b",
	cursor_bg = "#47FF9C",
	cursor_border = "#c0caf5",
	cursor_fg = "#1a1b26",
	selection_bg = "#283457",
	selection_fg = "#c0caf5",

	ansi = { "#15161e", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
	brights = { "#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" },
}

config.keys = {
	-- disabled to cmd+t is create new tab.
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
}
-- and finally, return the configuration to wezterm
return config
