return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    ft = "markdown",
  },
  {
    "mpas/marp-nvim",
    config = function()
      require("marp").setup({
        port = 8081,
        wait_for_response_timeout = 30,
        wait_for_response_delay = 1,
      })
      vim.keymap.set("n", "<leader>mt", "<cmd>MarpToggle<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ms", "<cmd>MarpStatus<cr>", { noremap = true, silent = true })
    end,
  },
}
