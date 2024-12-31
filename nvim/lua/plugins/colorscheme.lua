return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      require("solarized-osaka").setup({
        comments = { italic = true },
        keywords = { italic = true },

        on_colors = function(colors)
          colors.base0 = colors.base1
        end,
        on_highlights = function(hl, c)
          local number_fg = c.violet500
          hl["@number"] = {
            fg = number_fg,
          }
          hl.Number = {
            fg = number_fg,
          }
          hl["@lsp.type.number"] = {
            fg = number_fg,
          }
          hl.LspKindNumber = {
            fg = number_fg,
          }
          hl.LineNr = {
            fg = c.base01,
          }
          hl.CursorLineNr = {
            fg = c.yellow500,
          }
        end,
      })
      vim.cmd([[colorscheme solarized-osaka]])
    end,
  },
}
