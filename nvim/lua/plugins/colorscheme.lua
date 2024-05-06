return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
    },
    on_colors = function(colors)
      colors.base0 = colors.base1
    end,
    on_highlights = function(hl, c) end,
  },
  -- {
  --   "bluz71/vim-nightfly-guicolors",
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd([[colorscheme nightfly]])
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
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
        transparent = true,
        -- transparent = false,
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = bg_dark
          colors.bg_float = bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = bg_dark
          colors.bg_statusline = bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
        end,

        on_highlights = function(hl, c)
          hl.CursorLineNr.fg = c.orange
        end,
      })
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    {
      "maxmx03/solarized.nvim",
      config = function()
        vim.o.background = "dark" -- or 'light'

        require("solarized").setup({
          styles = {
            comments = { italic = true, bold = false },
            functions = { italic = false, bold = false },
            variables = { italic = false, bold = false },
          },
          transparent = true,
          theme = "default", -- or 'neo'
          colors = function(colors, colorhelper)
            local darken = colorhelper.darken

            return {
              bg = darken(colors.base03, 70),
            }
          end,
          highlights = function(c, colorhelper)
            local darken = colorhelper.darken
            return {
              Number = { fg = c.cyan },

              CursorLineNr = { fg = c.yellow },
              -- MatchParen = { fg = c.red }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
              keyword = { fg = c.green, bold = false },
              Function = { italic = false },
              -- DiffViewSidebar
              diffAdded = { fg = c.green },
              diffRemoved = { fg = c.red },
              diffChanged = { fg = c.yellow },
              diffOldFile = { fg = c.violet },
              diffNewFile = { fg = c.orange },
              diffFile = { fg = c.blue },
              diffLine = { fg = c.base01 },
              diffIndexLine = { fg = c.magenta },
              ["@punctuation.bracket"] = { fg = c.base0 }, -- For brackets and parens.
              -- WhichKey
              WhichKey = { fg = c.cyan },
              WhichKeyGroup = { fg = c.blue },
              WhichKeyDesc = { fg = c.magenta },
              WhichKeySeparator = { fg = c.base1 },
              WhichKeyFloat = { bg = c.bg_sidebar },
              WhichKeyValue = { fg = c.violet },
              -- DiffView
              DiffViewAsAdd = { fg = c.bg },
              DiffDelete = { bg = c.base00, fg = darken(c.red, 60) },
              DiffChange = { bg = "NONE", fg = darken(c.yellow, 40) },
              DiffText = { bg = "NONE" },

              -- Barbar
              BufferCurrent = { bg = c.bg, fg = c.fg },
              BufferCurrentERROR = { bg = c.bg, fg = c.error },
              BufferCurrentHINT = { bg = c.bg, fg = c.hint },
              BufferCurrentINFO = { bg = c.bg, fg = c.info },
              BufferCurrentWARN = { bg = c.bg, fg = c.warning },
              BufferCurrentIndex = { bg = c.bg, fg = c.info },
              BufferCurrentMod = { bg = c.bg, fg = c.warning },
              BufferCurrentSign = { bg = c.bg, fg = c.hint },
              BufferCurrentTarget = { bg = c.bg, fg = c.red },
              BufferCurrentADDED = { fg = c.hint, bg = c.bg },
              BufferCurrentCHANGED = { fg = c.warning, bg = c.bg },
              BufferCurrentDELETED = { fg = c.warning, bg = c.bg },
              BufferAlternate = { bg = c.fg_gutter, fg = c.fg },
              BufferAlternateERROR = { bg = c.fg_gutter, fg = c.error },
              BufferAlternateHINT = { bg = c.fg_gutter, fg = c.hint },

              -- indent-blankline
              IblINdent = { fg = darken(c.base01, 40) },
            }
          end,
        })
      end,
    },
  },
}
