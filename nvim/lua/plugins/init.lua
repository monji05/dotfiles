vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if kind == "delete" then
			return
		end
		if name == "nvim-treesitter" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		elseif name == "vim-doge" then
			if not ev.data.active then
				vim.cmd.packadd("vim-doge")
			end
			vim.cmd("call doge#install()")
		end
	end,
})

vim.pack.add({
	-- libraries
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-tree/nvim-web-devicons",

	-- colorscheme
	"https://github.com/craftzdog/solarized-osaka.nvim",

	-- UI
	"https://github.com/folke/snacks.nvim",
	"https://github.com/b0o/incline.nvim",
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",
	"https://github.com/shellRaining/hlchunk.nvim",
	"https://github.com/m-demare/hlargs.nvim",
	"https://github.com/NvChad/nvim-colorizer.lua",
	"https://github.com/nacro90/numb.nvim",
	"https://github.com/xzbdmw/colorful-menu.nvim",
	"https://github.com/emmanueltouzery/key-menu.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/rachartier/tiny-cmdline.nvim",

	-- coding
	{ src = "https://github.com/altermo/ultimate-autopair.nvim", version = "v0.6" },
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/nvim-mini/mini.surround",
	"https://github.com/Wansmer/treesj",
	"https://github.com/chrisgrieser/nvim-genghis",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/kkoomen/vim-doge",
	"https://github.com/stevearc/conform.nvim",

	-- treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	"https://github.com/nvim-treesitter/nvim-treesitter-context",

	-- LSP / completion / format / lint
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvimdev/lspsaga.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/nvimtools/none-ls.nvim",

	-- git
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/esmuellert/codediff.nvim",
	{ src = "https://github.com/craftzdog/mini.diff", version = "feat/grouping" },

	-- docs / markup / preview
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("plugins.ui")
require("plugins.snacks")
require("plugins.editor")
require("plugins.lsp")
require("plugins.coding")
require("plugins.util")
require("plugins.linter")
require("plugins.keymaps")
