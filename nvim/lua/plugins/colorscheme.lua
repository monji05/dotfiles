return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      require("solarized-osaka").setup({
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { italic = true },
          floats = "transparent",
        },

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
            -- bg = c.base02,
          }
          hl.CursorLineNr = {
            fg = c.yellow500,
            bg = c.base02,
          }
          -- hl.GitSignsAdd = {
          --   fg = c.green500,
          --   bg = c.base02,
          -- }
          -- hl.GitSignsChange = {
          --   fg = c.yellow500,
          --   bg = c.base02,
          -- }
          -- hl.GitSignsDelete = {
          --   fg = c.red500,
          --   bg = c.base02,
          -- }
          -- hl.DiagnosticHint = {
          --   bg = c.green900,
          --   fg = c.green500,
          -- }
        end,
      })
      vim.cmd([[colorscheme solarized-osaka]])
    end,
  },
  {
    "vague2k/vague.nvim",
    config = function(_, opts)
      require("vague").setup({
        transparent = true,
        bold = false,
        italic = true,
      })
      vim.cmd([[colorscheme vague]])
    end,
  },
}
