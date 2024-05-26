-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.setは複数のモードを指定できる {"i", "n"}

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.keymap.del("n", "<leader>ww")
vim.keymap.del("n", "<leader>wd")
vim.keymap.del("n", "<leader>w-")
vim.keymap.del("n", "<leader>w|")
vim.keymap.del("n", "<leader>qd")
vim.keymap.del("n", "<leader>ql")
vim.keymap.del("n", "<leader>qq")
vim.keymap.del("n", "<leader>qs")

-- save on <Space> w
keymap("n", "<leader>w", ":w<CR>", { noremap = false, desc = "save current file" })

-- close current file on <Space> x
keymap("n", "<leader>q", ":q<CR>", { noremap = false, desc = "quit current file" })

-- cc to :nohl
keymap("n", "cc", ":nohl<CR>", opts)

-- <C-r> to :source %
keymap("n", "<C-r>", ":source %<CR>", opts)

-- increment / decrement
keymap("n", "-", "<C-x>", opts)
keymap("n", "+", "<C-a>", opts)

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- New tab
keymap("n", "te", ":tabedit<CR>", opts)

-- Split window
keymap("n", "ss", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)

-- Move window
keymap("", "sh", "<C-w>h", opts)
keymap("", "sk", "<C-w>k", opts)
keymap("", "sj", "<C-w>j", opts)
keymap("", "sl", "<C-w>l", opts)

-- Resize window
keymap("n", "<C-w><left>", ":vertical resize +3<CR>", opts)
keymap("n", "<C-w><right>", ":vertical resize -3<CR>", opts)
keymap("n", "<C-w><up>", "<C-w>+", opts)
keymap("n", "<C-w><down>", "<C-w>-", opts)

-- レジスタを上書きせずに現在行を下にコピーする :t
keymap("n", "t", ":t.<CR>", opts)

-- use x, s command not using register
keymap("n", "x", '"_x', opts)
keymap("n", "s", '"_s', opts)

-- execute . command each line in visual mode selection
-- '<,'> normal .

-- ビジュアルモードでヤンクしたワードを連続でペーストできるように(最高)
keymap("v", "p", '"_xP', opts)

-- automatically create PHP Doc
keymap("i", "/*", " /**\n *\n*\n*\n*/<left><left><left><left>", opts)

-- replace current cursor word
keymap("v", "<leader>r", '"hy:%s/<C-r>h//g<left><left>', opts)

-- sort selected line in visual mode
keymap("v", "<C-s>", ":sort<CR>", opts)

-- reload config
keymap("n", "<leader>R", ":source ~/.config/nvim/init.lua<CR>", opts)

keymap("n", "∆", ":m .+1<CR>==", opts)
keymap("n", "˚", ":m .-2<CR>==", opts)
keymap("i", "∆", "<ESC>:m .+1<CR>==gi", opts)
keymap("i", "˚", "<ESC>:m .-2<CR>==gi", opts)
keymap("v", "∆", ":m '>+1<CR>gv=gv", opts)
keymap("v", "˚", ":m '<-2<CR>gv=gv", opts)

-- keymap("n", "<Tab>", ":tabNext<CR>", opts)
-- keymap("n", "<S-Tab>", ":tabPrevious<CR>", opts)
