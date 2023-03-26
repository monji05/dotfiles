return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  keys = {
    { "<leader>t",  "<CMD>TroubleToggle<CR>" },
    { "<leader>td", "<CMD>TroubleToggle document_diagnostics<CR>" },
    { "<leader>tq", "<CMD>Trouble quickfix<CR>" },
    { "<leader>tl", "<CMD>Trouble lsp_definitions<CR>" },
  },
}
