local keymap = vim.keymap
keymap.set("n", "∆", ":m .+1<CR>==")
keymap.set("n", "˚", ":m .-2<CR>==")
keymap.set("i", "∆", "<ESC>:m .+1<CR>==gi")
keymap.set("i", "˚", "<ESC>:m .-2<CR>==gi")
keymap.set("v", "∆", ":m '>+1<CR>gv=gv")
keymap.set("v", "˚", ":m '<-2<CR>gv=gv")

vim.opt.clipboard:append("unnamedplus")
