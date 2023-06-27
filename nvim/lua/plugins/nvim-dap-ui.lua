require('dapui').setup({
  icons = { expanded = "", collapsed = "" },
  layouts = {
    {
      elements = {
        { id = "watches",     size = 0.20 },
        { id = "stacks",      size = 0.20 },
        { id = "breakpoints", size = 0.20 },
        { id = "scopes",      size = 0.40 },
      },
      size = 50,
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.20,
      position = "bottom",
    },
  },
})

vim.api.nvim_set_keymap('n', "<leader>tu", "<Cmd>lua require('dapui').toggle()<CR>", { silent = true })
