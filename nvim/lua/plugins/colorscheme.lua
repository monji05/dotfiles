return {
  -- {
  --   "craftzdog/solarized-osaka.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   event = { "BufReadPost", "BufAdd", "BufNewFile" },
  --   config = function()
  --     require("solarized-osaka").setup({
  --       styles = {
  --         comments = { italic = true },
  --         keywords = { italic = true },
  --         functions = { italic = true },
  --         floats = "transparent",
  --       },
  --
  --       on_colors = function(colors)
  --         colors.base0 = colors.base1
  --       end,
  --       on_highlights = function(hl, c)
  --         local number_fg = c.violet500
  --         hl["@number"] = {
  --           fg = number_fg,
  --         }
  --         hl.Number = {
  --           fg = number_fg,
  --         }
  --         hl["@lsp.type.number"] = {
  --           fg = number_fg,
  --         }
  --         hl.LspKindNumber = {
  --           fg = number_fg,
  --         }
  --         hl.LineNr = {
  --           fg = c.base01,
  --           -- bg = c.base02,
  --         }
  --         hl.CursorLineNr = {
  --           fg = c.yellow500,
  --           bg = c.base02,
  --         }
  --         -- hl.GitSignsAdd = {
  --         --   fg = c.green500,
  --         --   bg = c.base02,
  --         -- }
  --         -- hl.GitSignsChange = {
  --         --   fg = c.yellow500,
  --         --   bg = c.base02,
  --         -- }
  --         -- hl.GitSignsDelete = {
  --         --   fg = c.red500,
  --         --   bg = c.base02,
  --         -- }
  --         -- hl.DiagnosticHint = {
  --         --   bg = c.green900,
  --         --   fg = c.green500,
  --         -- }
  --       end,
  --     })
  --     vim.cmd([[colorscheme solarized-osaka]])
  --   end,
  -- },
  -- {
  --   "vague2k/vague.nvim",
  --   config = function(_, opts)
  --     require("vague").setup({
  --       transparent = true,
  --       bold = false,
  --       italic = true,
  --     })
  --     vim.cmd([[colorscheme vague]])
  --   end,
  -- },
  -- {
  --   "Mofiqul/vscode.nvim",
  --   config = function()
  --     local c = require("vscode.colors").get_colors()
  --     require("vscode").setup()
  --     vim.cmd([[colorscheme vscode]])
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      local transparent = true -- set to true if you would like to enable transparency

      local bg = "#011628"
      local bg_dark = "#011423"
      local bg_highlight = "#143652"
      local bg_search = "#0A64AC"
      local bg_visual = "#275378"
      local fg = "#CBE0F0"
      local fg_dark = "#B4D0E9"
      local fg_gutter = "#627E97"
      local border = "#547998"

      require("tokyonight").setup({
        style = "night",
        transparent = transparent,
        styles = {
          sidebars = transparent and "transparent" or "dark",
          floats = transparent and "transparent" or "dark",
        },
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = transparent and colors.none or bg_dark
          colors.bg_float = transparent and colors.none or bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = transparent and colors.none or bg_dark
          colors.bg_statusline = transparent and colors.none or bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
        end,
      })

      vim.cmd("colorscheme tokyonight")
    end,
  },
}
