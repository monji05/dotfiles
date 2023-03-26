return {
  "folke/which-key.nvim",
  event = "BufRead",
  opts = function()
    require("which-key").setup({})
  end,
}
