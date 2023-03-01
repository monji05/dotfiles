local keymap = vim.keymap

keymap.set('n', '<A-j>', '∆ :m .+1<CR>==')
keymap.set('n', '<A-k>', '˚ :m .-2<CR>==')
keymap.set('i', '<A-j>', '∆ <ESC>:m .+1<CR>==gi')
keymap.set('i', '<A-k>', '˚ <ESC>:m .-2<CR>==gi')
keymap.set('v', 'A-j', "∆ :m '>+1<CR>gv=gv")
keymap.set('v', 'A-k', "˚ :m '<-2<CR>gv=gv")
