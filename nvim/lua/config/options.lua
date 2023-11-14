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
vim.opt.swapfile = false
vim.opt.showtabline = 2

-- hightlight
vim.opt.cursorline = true
vim.opt.termguicolors = true
-- winblend = 0 is required for noice background color on neosolarized_dark
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 0 -- transparency popup for lsp, float window
vim.opt.background = "dark"

-- not sync scroll when using split view
vim.g.noscb = true

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
vim.g.gitblame_enabled = 0

-- fast start up
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spec = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.load_black = 1
vim.g.loaded_fzf = 1
vim.g.loaded_gtags = 1
vim.g.loaded_gtags_cscope = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_pythonx_provider = 0
vim.g.loaded_ruby_provider = 0

-- statuscolumn to right of line numbers
vim.opt.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} %s"
