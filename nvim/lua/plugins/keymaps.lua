local keymap = vim.keymap.set
-- keymap for plugins
keymap("n", "<Leader>f", ":Oil<CR>", { noremap = true, silent = true })

-- key-menu.nvim
vim.o.timeoutlen = 300
local key_menu = require("key-menu")

-- If you use <Space> as your mapping prefix, then this will make the key-menu
-- popup appear in Normal mode, after you press <Space>, after timeoutlen.
key_menu.set("n", "<leader>")
key_menu.set("n", ";")
key_menu.set("n", "[")

-- To describe the group of mappings under <Space>g, use key-menu.set.
key_menu.set("n", "<Space>g", { desc = "Git" })
key_menu.set("n", "g")
