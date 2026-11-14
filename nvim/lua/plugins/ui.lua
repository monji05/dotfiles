local icons = require("utils.icons")
require("solarized-osaka").setup({
	style = "vivid",
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = { italic = true },
		floats = "transparent",
		sidebars = "transparent",
	},

	---@param hl Highlights
	---@param c ColorScheme
	on_highlights = function(hl, c)
		hl.LineNr = { fg = c.base01 }
	end,
})

vim.cmd.colorscheme("solarized-osaka")

-- hlargs
-- Must run after the colorscheme: it copies the colour of the parameter group.
require("hlargs").setup({})

-- candidate highlight groups for function parameters (priority order)
local param_groups = {
	"@variable.parameter", -- Treesitter (Neovim 0.9+)
	"@lsp.type.parameter", -- LSP semantic tokens
	"@parameter", -- legacy Treesitter
	"Identifier", -- Vim fallback
}

local fg_color
for _, group_name in ipairs(param_groups) do
	local hl = vim.api.nvim_get_hl(0, { name = group_name, link = false })
	if hl and hl.fg then
		fg_color = hl.fg
		break
	end
end

if fg_color then
	vim.api.nvim_set_hl(0, "Hlargs", { fg = string.format("#%06x", fg_color) })
end

local colors = require("solarized-osaka.colors").setup()

require("incline").setup({
	highlight = {
		groups = {
			InclineNormal = { guibg = colors.orange500, guifg = colors.base04 },
			InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
		},
	},
	hide = {
		cursorline = true,
	},
	window = {
		placement = {
			horizontal = "center",
			vertical = "top",
		},
		margin = {
			vertical = 0,
			horizontal = 0,
		},
	},

	render = function(props)
		-- 現在のバッファのプロジェクトルートからの相対パスを取得
		local bufpath = vim.api.nvim_buf_get_name(props.buf)
		if bufpath == "" then
			return "[No Name]"
		end

		local relpath = vim.fn.fnamemodify(bufpath, ":~:.")
		local filename = vim.fn.fnamemodify(bufpath, ":t")
		local dirpath = vim.fn.fnamemodify(relpath, ":h")

		-- ルート直下でない場合は末尾にスラッシュを付与
		if dirpath ~= "." then
			dirpath = dirpath .. "/"
		else
			dirpath = ""
		end
		local ft_icon, ft_color = icons.file_icon_color(filename)
		local separator = { "┊ ", guifg = colors.blue }

		local is_modified = {}
		if vim.bo[props.buf].modified then
			table.insert(is_modified, { " " .. "[+]" })
		end
		return {
			-- { show_git_branch() },
			-- { get_diagnostic_label() },
			-- { get_git_diff() },
			{ (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
			{ dirpath .. filename, gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
			{ is_modified },
		}
	end,
})

-- render-markdown
require("render-markdown").setup({})

-- treesitter
require("nvim-treesitter").setup({})

require("nvim-treesitter").install({
	"vim",
	"php",
	"diff",
	"lua",
	"json",
	"go",
	"javascript",
})

-- colorizer
require("colorizer").setup({
	user_default_options = {
		RGB = true, -- #RGB hex codes
		RRGGBB = true, -- #RRGGBB hex codes
		names = false, -- "Name" codes like Blue or blue
		RRGGBBAA = false, -- #RRGGBBAA hex codes
		AARRGGBB = false, -- 0xAARRGGBB hex codes
		rgb_fn = true, -- CSS rgb() and rgba() functions
		hsl_fn = true, -- CSS hsl() and hsla() functions
		css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		-- Available modes for `mode`: foreground, background,  virtualtext
		mode = "background", -- Set the display mode.
		-- Available methods are false / true / "normal" / "lsp" / "both"
		-- True is same as normal
		tailwind = true, -- Enable tailwind colors
		-- parsers can contain values used in |user_default_options|
		sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
		virtualtext = "■",
		-- update color values even if buffer is not focused
		-- example use: cmp_menu, cmp_docs
		always_update = false,
	},
})

-- mini.icons
require("mini.icons").setup({
	extension = {
		["php"] = {
			glyph = "",
			hl = "MiniIconsPurple",
		},
		["blade.php"] = {
			glyph = "󰫐",
			hl = "MiniIconsRed",
		},
		["composer.lock"] = {
			glyph = "",
			hl = "MiniIconsRed",
		},
	},
})

require("tiny-cmdline").setup({
	position = {
		y = "20%",
	},
})

vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
		format = function(diagnostic)
			return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
		end,
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
			[vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
			[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
			[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
		},
	},
})
