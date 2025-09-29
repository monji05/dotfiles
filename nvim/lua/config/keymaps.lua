-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.setは複数のモードを指定できる {"i", "n"}

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- jj is enable to move to normal mode
keymap("i", "jj", "<ESC><CR>", opts)

-- save on <Space> w
keymap("n", "<leader>w", ":w<CR>", { noremap = false, desc = "save current file" })

-- close current file on <Space> x
keymap("n", "<leader>q", ":q<CR>", { noremap = false, desc = "quit current file" })

-- cc to :nohl
keymap("n", "cc", ":nohl<CR>", opts)

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- New tab
keymap("n", "te", ":tabedit<CR>", opts)

-- Split window
keymap("n", "ss", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)

-- Move window
-- keymap("", "sh", "<C-w>h", opts)
-- keymap("", "sk", "<C-w>k", opts)
-- keymap("", "sj", "<C-w>j", opts)
-- keymap("", "sl", "<C-w>l", opts)

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

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-f>", "<C-f>zz", opts)
keymap("n", "<C-b>", "<C-b>zz", opts)

keymap("n", "Y", "yy", opts)
