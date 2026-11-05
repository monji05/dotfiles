require("codediff").setup({
  explorer = {
    auto_open_on_cursor = true, -- auto-open diff for file under cursor while moving
    auto_open_debounce_ms = 80, -- debounce window (ms) for the above
    view_mode = "tree",
  },
})

vim.keymap.set("n", "<leader>do", "<CMD>CodeDiff<CR>", { desc = "CodeDiff" })
