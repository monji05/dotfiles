local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- save on <Space> w
keymap("n", "<Space>w", ":w<CR>", opts)

-- close current file on <Space> x
keymap("n", "<Space>q", ":q<CR>", opts)

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
keymap("n", "<C-w><left>", "<C-w><", opts)
keymap("n", "<C-w><right>", "<C-w>>", opts)
keymap("n", "<C-w><up>", "<C-w>+", opts)
keymap("n", "<C-w><down>", "<C-w>-", opts)

-- レジスタを上書きせずに現在行を下にコピーする :t
keymap("n", "p", ":t.<CR>", opts)

-- use x, s command not using register
keymap("n", "x", '"_x', opts)
keymap("n", "s", '"_s', opts)

-- execute . command each line in visual mode selection
-- '<,'> normal .

-- ビジュアルモードでヤンクしたワードを連続でペーストできるように(最高)
keymap("x", "p", '"_xp', opts)
