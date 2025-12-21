return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {
      day_brightness = 0.5,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { italic = true },
        floats = "transparent",
        sidebars = "transparent",
      },

      on_colors = function(colors)
        colors.base0 = "#92a0a0"
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
          fg = c.yellow300,
          bg = c.yellow700,
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
        --
        -- word_diff
        hl.GitSignsAddLnInline = {
          bg = c.green700,
          -- fg = c.base01,
        }
        hl.GitSignsAddLn = {
          bg = c.green700,
        }
        hl.GitSignsUntrackedLn = {
          bg = c.magenta,
        }
        hl.GitSignsChangeLn = {
          bg = c.yellow900,
          -- fg = c.base01,
        }
        hl.GitSignsChangeLnInline = {
          bg = c.yellow700,
        }
      end,
    },
  },
}
