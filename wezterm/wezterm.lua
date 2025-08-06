-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- For example, changing the color scheme:
config.font = wezterm.font("PlemolJP35 Console NF")

config.default_prog = { "/opt/homebrew/bin/fish" }

config.font_size = 17
config.window_background_opacity = 0.85
config.macos_window_background_blur = 30
config.window_decorations = "RESIZE"

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false
config.initial_cols = 220 -- 横のサイズ
config.initial_rows = 60 -- 縦のサイズ

-- tabが一つしかない場合はtab barを非表示
config.hide_tab_bar_if_only_one_tab = true

-- tab barを透明にする
config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}

-- tab barを背景色と同色にする
-- 背景色を変えたい場合はここで
config.window_background_gradient = {
	-- solarized-osaka
	colors = { "#001b22" }, -- stronger than #002b36

	-- vague
	-- colors = { "#141415" },
	-- colors = { "#202022" }, -- more weak than #141415
	-- colors = { "#1e1e1f" }, -- more weak than #141415

	-- tokyonight
	-- colors = { "#011628" },
}

-- tab barの+を非表示にする
config.show_new_tab_button_in_tab_bar = false

-- NOTE: pane間を移動する際はCtrl+Shift+{Left, Right, Up, Down}
-- NOTE: split vertical pane key is Ctrl+Shift+Alt+"
-- NOTE: split horizon pane key is Ctrl+Shift+Alt+%

-- tabの形を変更
-- アクティブtabに色をつける
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"
	local edge_background = "none"
	if tab.is_active then
		background = "#ae8b2d"
		foreground = "#FFFFFF"
	end
	local edge_foreground = background
	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)
-- solarized-osaka night colorscheme
config.colors = {
	-- solarized-osaka

	cursor_bg = "#47FF9C",
	cursor_border = "#c0caf5",
	cursor_fg = "#1a1b26",
	selection_bg = "#283457",
	selection_fg = "#c0caf5",

	ansi = { "#15161e", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
	brights = { "#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" },

	-- tab間の境界線を非表示
	tab_bar = {
		inactive_tab_edge = "none",
	},
}

-- tokyonight
-- config.colors = {
-- 	foreground = "#CBE0F0",
-- 	background = "#011423",
-- 	cursor_bg = "#47FF9C",
-- 	cursor_border = "#47FF9C",
-- 	cursor_fg = "#011423",
-- 	selection_bg = "#033259",
-- 	selection_fg = "#CBE0F0",
-- 	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- 	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }

local act = wezterm.action
config.keys = {
	{
		key = "\\",
		mods = "CTRL",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "CTRL",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- NOTE: modsに複数のkeyを定義したいときはCTRL|SHIFTでCtrl+Shiftとなる
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = act.DisableDefaultAssignment,
	},
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
}
-- and finally, return the configuration to wezterm
return config
