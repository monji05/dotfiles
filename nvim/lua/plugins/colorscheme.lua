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
          hl["@punctuation.bracket"] = { fg = c.magenta }
        end,
      })
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    build = ":CatppuccinCompile",
    config = function()
      local colors = require("catppuccin.palettes").get_palette() -- fetch colors from palette

      local options = {
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "macchiato",
        },
        transparent_background = true,
        compile = {
          enabled = true,
          path = vim.fn.stdpath("cache") .. "/catppuccin",
        },
        integrations = {
          dap = {
            enabled = true,
            enable_ui = true,
          },
          cmp = true,
          leap = true,
        },
        custom_highlights = {
          Comment = { fg = colors.surface2, style = { "italic" } }, -- just comments
          Constant = { fg = colors.peach }, -- (preferred) any constant
          String = { fg = colors.yellow, style = { "italic", "bold" } }, -- a string constant: "this is a string"
          Character = { fg = colors.teal }, --  a character constant: 'c', '\n'
          Number = { fg = colors.maroon }, --   a number constant: 234, 0xff
          Float = { fg = colors.maroon }, --    a floating point constant: 2.3e10
          Boolean = { fg = colors.maroon }, --  a boolean constant: TRUE, false
          Identifier = { fg = colors.text }, -- (preferred) any variable name
          Function = { fg = colors.green }, -- function name (also: methods for classes)
          Statement = { fg = colors.mauve }, -- (preferred) any statement
          Conditional = { fg = colors.red }, --  if, then, else, endif, switch, etcp.
          Repeat = { fg = colors.red }, --   for, do, while, etcp.
          Label = { fg = colors.peach }, --    case, default, etcp.
          Operator = { fg = colors.text }, -- "sizeof", "+", "*", etcp.
          Keyword = { fg = colors.pink }, --  any other keyword
          PreProc = { fg = colors.peach }, -- (preferred) generic Preprocessor
          Include = { fg = colors.green }, --  preprocessor #include
          StorageClass = { fg = colors.yellow }, -- static, register, volatile, etcp.
          Structure = { fg = colors.yellow }, --  struct, union, enum, etcp.
          Typedef = { fg = colors.yellow }, --  A typedef
          Special = { fg = colors.peach }, -- (preferred) any special symbol
          Type = { fg = colors.teal }, -- (preferred) int, long, char, etcp.
          TSInclude = { fg = colors.peach, style = { "italic" } },
          ["@include"] = { fg = colors.peach, style = { "italic" } },
          TSField = { fg = colors.blue }, -- For fields.
          ["@field"] = { fg = colors.blue }, -- For fields.
          TSProperty = { fg = colors.blue }, -- Same as TSField.
          ["@property"] = { fg = colors.blue }, -- Same as TSField.
          TSConstant = { fg = colors.maroon }, -- For constants
          ["@constant.builtin"] = { fg = colors.maroon }, -- For constants
          TSParameter = { fg = colors.text, style = { "italic" } }, -- For parameters of a function.
          ["@parameter"] = { fg = colors.text, style = { "italic" } }, -- For parameters of a function.
          TSOperator = { fg = colors.text },
          ["@operator"] = { fg = colors.text },
          TSKeywordFunction = { fg = colors.peach }, -- For keywords used to define a fuction.
          ["@keyword.function"] = { fg = colors.peach }, -- For keywords used to define a fuction.
          TSKeyword = { fg = colors.peach }, -- For keywords that don't fall in previous categories.
          ["@keyword"] = { fg = colors.peach }, -- For keywords that don't fall in previous categories.
          TSKeywordReturn = { fg = colors.peach },
          ["@keyword.return"] = { fg = colors.peach },
          TSType = { fg = colors.teal }, -- For types.
          ["@type"] = { fg = colors.teal }, -- For types.
          TSTypeBuiltin = { fg = colors.teal, style = { "italic" } }, -- For builtin types.
          ["@type.builtin"] = { fg = colors.teal, style = { "italic" } }, -- For builtin types.
          TSVariableBuiltin = { fg = colors.red }, -- Variable names that are defined by the languages, like this or self.
          ["@variable.builtin"] = { fg = colors.red }, -- Variable names that are defined by the languages, like this or self.
          TSFunction = { fg = colors.green }, -- For function (calls and definitions).
          ["@function.builtin"] = { fg = colors.green }, -- For function (calls and definitions).
          TSMethod = { fg = colors.green }, -- For method calls and definitions.
          ["@function"] = { fg = colors.green }, -- For method calls and definitions.
          TSString = { fg = colors.yellow, style = { "italic" } }, -- For strings.
          ["@string"] = { fg = colors.yellow, style = { "italic" } }, -- For strings.
          BufferLineSeparator = { fg = colors.peach, bg = "NONE" },
          BufferLineBufferVisible = { fg = colors.surface1, bg = "NONE" },
          BufferLineBufferSelected = { fg = colors.text, bg = "NONE", style = { "bold", "italic" } }, -- current
          BufferLineIndicatorSelected = { fg = colors.peach, bg = "NONE" },
        },
      }

      require("catppuccin").setup(options)

      vim.cmd([[colorscheme catppuccin]])
    end,
  },
  {
    "kepano/flexoki-neovim",
    name = "flexoki",
    config = function()
      require("flexoki").setup({
        transparent = true,
      })
      -- vim.cmd([[colorscheme flexoki-dark]])
    end,
  },
}
