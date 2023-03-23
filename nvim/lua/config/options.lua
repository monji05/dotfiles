vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.autoindent = true
vim.opt.fillchars = "diff:╱"
opt.laststatus = 3
opt.list = false -- Show some invisible characters (tabs...
opt.mouse = "" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 30 -- Lines of context
opt.sidescrolloff = 30 -- Columns of context
opt.spelllang = { "en" }
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold

if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "screen"
	opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
