return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = "nvim-telescope/telescope-file-browser.nvim",
	keys = function()
		return {
			{ ";f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ ";r", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		}
	end,
}
