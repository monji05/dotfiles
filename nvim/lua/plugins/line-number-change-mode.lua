return {
  {
    "sethen/line-number-change-mode.nvim",
    config = function()
      local color = require("solarized-osaka.colors")
      require("line-number-change-mode").setup({
        mode = {
          i = {
            bg = color.default.green500,
            fg = color.default.base02,
          },
          n = {
            bg = color.default.blue500,
            fg = color.default.base02,
          },
          v = {
            bg = color.default.magenta500,
            fg = color.default.base02,
          },
          V = {
            bg = color.default.magenta500,
            fg = color.default.base02,
          },
          R = {
            bg = color.default.red500,
            fg = color.default.base02,
          },
        },
      })
    end,
  },
}
