require("Comment").setup({
	toggler = {
		line = "<leader>u",
		block = "gc",
	},
})

require("ultimate-autopair").setup({
	fastwarp = { -- *ultimate-autopair-map-fastwarp-config*
		enable = true,
		enable_normal = true,
		enable_reverse = true,
		hopout = false,
		--{(|)} > fastwarp > {(}|)
		map = "<C-l>", --string or table
		rmap = "<C-h>", --string or table
		cmap = "<C-l>", --string or table
		rcmap = "<C-h>", --string or table
	},

	bs = { -- *ultimate-autopair-map-backspace-config*
		single_delete = true,
		-- <!--|--> > bs > <!-|
	},
})

-- change html tag command is srtt"
-- Use `''` (empty string) to disable a mapping.
require("mini.surround").setup({
	mappings = {
		add = "sa", -- Add surrounding in Normal and Visual modes
		delete = "sd", -- Delete surrounding
		find = "sf", -- Find surrounding (to the right)
		find_left = "sF", -- Find surrounding (to the left)
		highlight = "sh", -- Highlight surrounding
		replace = "sr", -- Replace surrounding

		suffix_last = "l", -- Suffix to search with "prev" method
		suffix_next = "n", -- Suffix to search with "next" method
	},
})

require("conform").setup({
	formatters_by_ft = {
		json = { "fixjson", "jq" },
		php = { "phpcbf" },
		javascript = { "biome" }, -- faster 35x than prettier
		typescript = { "biome" },
		go = { "gofumpt" },
		lua = { "stylua" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("conform-format-on-save", { clear = true }),
	callback = function(args)
		require("conform").format({ bufnr = args.buf, timeout_ms = 500, lsp_format = "fallback" })
	end,
})
