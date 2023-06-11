return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional dependency
    "SmiteshP/nvim-navic",
  },
  config = function()
    require("barbecue").setup({
      show_dirname = false,
      show_basename = false,
    })
  end,
}
