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
      -- theme = {
      --   normal = { fg = "#c0caf5" },
      --   ellipsis = { fg = "#737aa2" },
      --   separator = { fg = "#737aa2" },
      --   modified = { fg = "#737aa2" },
      --   dirname = { fg = "#737aa2" },
      --   basename = { bold = true },
      --   context = {},
      --   context_file = { fg = "#ac8fe4" },
      --   context_module = { fg = "#268bd2" },
      --   context_namespace = { fg = "#ac8fe4" },
      --   context_package = { fg = "#ac8fe4" },
      --   context_class = { fg = "#cb4b16" },
      --   context_method = { fg = "#268bd2" },
      --   context_property = { fg = "#268bd2" },
      --   context_field = { fg = "#268bd2" },
      --   context_constructor = { fg = "#cb4b16" },
      --   context_enum = { fg = "#ac8fe4" },
      --   context_interface = { fg = "#ac8fe4" },
      --   context_function = { fg = "#ac8fe4" },
      --   context_variable = { fg = "#ac8fe4" },
      --   context_constant = { fg = "#ac8fe4" },
      --   context_string = { fg = "#ac8fe4" },
      --   context_number = { fg = "#ac8fe4" },
      --   context_boolean = { fg = "#ac8fe4" },
      --   context_array = { fg = "#ac8fe4" },
      --   context_object = { fg = "#ac8fe4" },
      --   context_key = { fg = "#ac8fe4" },
      --   context_null = { fg = "#ac8fe4" },
      --   context_enum_member = { fg = "#ac8fe4" },
      --   context_struct = { fg = "#ac8fe4" },
      --   context_event = { fg = "#ac8fe4" },
      --   context_operator = { fg = "#ac8fe4" },
      --   context_type_parameter = { fg = "#ac8fe4" },
      -- },
      -- Color.new("yellow", "#b58900")
      -- Color.new("orange", "#cb4b16")
      -- Color.new("red", "#dc322f")
      -- Color.new("magenta", "#d33682")
      -- Color.new("violet", "#6c71c4")
      -- Color.new("blue", "#268bd2")
      -- Color.new("cyan", "#2aa198")
      -- Color.new("green", "#719e07")
      --
      -- Group.new("Error", colors.red)
      -- Group.new("Warning", colors.yellow)
      -- Group.new("Information", colors.blue)
      -- Group.new("Hint", colors.cyan)
    })
  end,
}
