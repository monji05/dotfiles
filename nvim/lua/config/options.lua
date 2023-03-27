vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.number = true

vim.opt.title = true

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2

vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smarttab = true

vim.opt.scrolloff = 30
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.wrap = false          -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.fillchars = "diff:╱"
vim.opt.laststatus = 3
vim.opt.iskeyword:append("-")
vim.opt.shada = ""

-- hightlight
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 10
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 10 -- transparency popup for lsp, float window
vim.opt.background = "dark"

-- Undercurl
vim.api.nvim_command([[let &t_Cs = "\e[4:3m"]])
vim.api.nvim_command([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- set theme on nvim-markdown-preview
vim.api.nvim_command([[let g:nvim_markdown_preview_theme = 'solarized-dark']])
