local keymap = vim.keymap
-- save on <Space> w
keymap.set("n", "<Space>w", ":w<CR>")

-- close current file on <Space> x
keymap.set("n", "<Space>x", ":q<CR>")

-- cc to :nohl
keymap.set("n", "cc", ":nohl<CR>")

-- <C-r> to :source %
keymap.set("n", "<C-r>", ":source %<CR>")

-- increment / decrement
keymap.set("n", "-", "<C-x>")
keymap.set("n", "+", "<C-a>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- New tab
keymap.set("n", "te", ":tabedit<CR>")

-- Split window
keymap.set("n", "ss", ":split<Return><C-w>w")
keymap.set("n", "sv", ":vsplit<Return><C-w>w")

-- Move window
keymap.set("", "sh", "<C-w>h")
keymap.set("", "sk", "<C-w>k")
keymap.set("", "sj", "<C-w>j")
keymap.set("", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")
