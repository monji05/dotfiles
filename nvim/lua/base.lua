vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.number = true

vim.opt.title = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.scrolloff = 30
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.fillchars = 'diff:╱'
vim.opt.laststatus = 3
vim.opt.iskeyword:append("-")
vim.opt.clipboard:append('unnamed')

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

-- yank to clipboard
vim.cmd([[
  if !empty($WSL_DISTRO_NAME)
     let s:clip = '/mnt/c/Windows/System32/clip.exe'
     if executable(s:clip)
       augroup WSLYank
         autocmd!
         autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
       augroup END
     endif
   endif
]])

-- set theme on nvim-markdown-preview
vim.cmd([[let g:nvim_markdown_preview_theme = 'solarized-dark']])
