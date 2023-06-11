return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = function()
    require("which-key").setup({})
  end,
}
