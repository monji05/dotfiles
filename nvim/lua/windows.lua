-- yank to clipboard on Windows
vim.api.nvim_command [[
  if !empty($WSL_DISTRO_NAME)
  let s:clip = '/mnt/c/Windows/System32/clip.exe'
  if executable(s:clip)
  augroup WSLYank
  autocmd!
  autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
  augroup END
  endif
  endif
]]
--move up/down current line
local keymap = vim.keymap
keymap.set('n', '<A-j>', ':m .+1<CR>==')
keymap.set('n', '<A-k>', ':m .-2<CR>==')
keymap.set('i', '<A-j>', '<ESC>:m .+1<CR>==gi')
keymap.set('i', '<A-k>', '<ESC>:m .-2<CR>==gi')
keymap.set('v', 'A-j', ":m '>+1<CR>gv=gv")
keymap.set('v', 'A-k', ":m '<-2<CR>gv=gv")
