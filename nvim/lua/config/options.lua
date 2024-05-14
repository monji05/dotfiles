-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.fn.has("unix") == 1 then
  vim.env.LANG = "en_US.UTF-8"
else
  vim.env.LANG = "en"
end

vim.o.encoding = "utf-8"
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
vim.opt.smarttab = true
vim.opt.shiftwidth = 2

vim.opt.scrolloff = 30
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.wrap = false          -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.laststatus = 3
vim.opt.iskeyword:append("-")
vim.opt.shada = ""
vim.opt.swapfile = false
-- vim.opt.showtabline = 2
vim.opt.shell = "fish"
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitkeep = "cursor"
vim.opt.mouse = ""

-- highlight
vim.opt.background = "dark"

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- set theme on nvim-markdown-preview
vim.api.nvim_command([[let g:nvim_markdown_preview_theme = 'solarized-osaka']])
vim.g.gitblame_enabled = 0

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
-- vim.cmd([[let &t_Cs = "\e[60m"]])
-- vim.cmd([[let &t_Ce = "\e[24m"]])
vim.cmd([[hi SpellBad   guisp=red    gui=undercurl term=underline cterm=undercurl]])
vim.cmd([[hi SpellCap   guisp=yellow gui=undercurl term=underline cterm=undercurl]])
vim.cmd([[hi SpellRare  guisp=blue   gui=undercurl term=underline cterm=undercurl]])
vim.cmd([[hi SpellLocal guisp=orange gui=undercurl term=underline cterm=undercurl]])
vim.cmd([[set spell]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })
