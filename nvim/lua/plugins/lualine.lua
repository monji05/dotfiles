return {
	{
		"nvim-lualine/lualine.nvim", -- Statusline
		event = { "InsertEnter", "CursorHold", "FocusLost", "BufRead", "BufNewFile" },
		config = function()
			local status, lualine = pcall(require, "lualine")
			if not status then
				return
			end

			lualine.setup({
				options = {
					icons_nabled = true,
					theme = "nightfly",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"filename",
							file_status = true, -- displays file status (readonly status, modified status)
							path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
						},
						"diff",
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
				},
				tabline = {},
				extensions = {},
			})
		end,
	},
}
