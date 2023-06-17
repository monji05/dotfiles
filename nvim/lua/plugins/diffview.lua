local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>do", "<CMD>DiffviewOpen<CR>", opts)
vim.keymap.set("n", "<leader>dc", "<CMD>DiffviewClose<CR>", opts)
