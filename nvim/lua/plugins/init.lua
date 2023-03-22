return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = {
				"tokyonight",
				-- "nightfly",
			},
		},
	},
	{
		"nvim-lua/popup.nvim",
		event = "BufRead",
		lazy = true,
	},
	{
		"nvim-lua/plenary.nvim",
		lazy = false,
	},
}
