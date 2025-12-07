return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {
      day_brightness = 0.5,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { italic = true },
        floats = "transparent",
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
  -- {
  --   "folke/tokyonight.nvim",
  --   priority = 1000,
  --   config = function()
  --     local transparent = true -- set to true if you would like to enable transparency
  --
  --     local bg = "#011628"
  --     local bg_dark = "#011423"
  --     local bg_highlight = "#143652"
  --     local bg_search = "#0A64AC"
  --     local bg_visual = "#275378"
  --     local fg = "#CBE0F0"
  --     local fg_dark = "#B4D0E9"
  --     local fg_gutter = "#627E97"
  --     local border = "#547998"
  --
  --     require("tokyonight").setup({
  --       style = "night",
  --       transparent = transparent,
  --       styles = {
  --         sidebars = transparent and "transparent" or "dark",
  --         floats = transparent and "transparent" or "dark",
  --       },
  --       on_colors = function(colors)
  --         colors.bg = bg
  --         colors.bg_dark = transparent and colors.none or bg_dark
  --         colors.bg_float = transparent and colors.none or bg_dark
  --         colors.bg_highlight = bg_highlight
  --         colors.bg_popup = bg_dark
  --         colors.bg_search = bg_search
  --         colors.bg_sidebar = transparent and colors.none or bg_dark
  --         colors.bg_statusline = transparent and colors.none or bg_dark
  --         colors.bg_visual = bg_visual
  --         colors.border = border
  --         colors.fg = fg
  --         colors.fg_dark = fg_dark
  --         colors.fg_float = fg
  --         colors.fg_gutter = fg_gutter
  --         colors.fg_sidebar = fg_dark
  --       end,
  --     })
  --
  --     vim.cmd("colorscheme tokyonight")
  --   end,
  -- },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   config = function()
  --     require("nightfox").setup({
  --       options = {
  --         transparent = true,
  --         styles = {
  --           comments = "italic", -- Value is any valid attr-list value `:help attr-list`
  --           functions = "italic",
  --           keywords = "italic",
  --         },
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "maxmx03/solarized.nvim",
  --   -- lazy = true,
  --   lazy = false,
  --   priority = 1000,
  --   ---@type solarized.config
  --   opts = {
  --     variant = "autumn",
  --     styles = {
  --       enabled = true,
  --       types = {},
  --       functions = { italic = true },
  --       parameters = {},
  --       comments = { italic = true },
  --       strings = {},
  --       keywords = { italic = true },
  --       variables = {},
  --       constants = {},
  --     },
  --     transparent = {
  --       enabled = true,
  --       pmenu = true,
  --       normal = true,
  --       normalfloat = true,
  --       neotree = true,
  --       nvimtree = true,
  --       whichkey = true,
  --       telescope = true,
  --       lazy = true,
  --     },
  --     on_highlights = function(colors, color)
  --       ---@type solarized.highlights
  --       local groups = {
  --         CursorLineNr = {
  --           bg = colors.mix_red,
  --         },
  --       }
  --       return groups
  --     end,
  --   },
  --   config = function(_, opts)
  --     vim.o.termguicolors = true
  --     vim.o.background = "dark"
  --     require("solarized").setup(opts)
  --     vim.cmd.colorscheme("solarized")
  --   end,
  -- },
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup({})
      -- solarized-osaka
      vim.api.nvim_command([[highlight Hlargs guifg=#c94c16]])

      -- tokyonight
      -- That is the same phpDoc argment color
      -- vim.api.nvim_command([[highlight Hlargs guifg=#e0af68]])

      -- nightfox (duskfox)
      -- vim.api.nvim_command([[highlight Hlargs guifg=#9ccfd8]])

      -- solarized
      -- vim.api.nvim_command([[highlight Hlargs guifg=#268BD2]])

      -- kanagawa-dragon
      -- vim.api.nvim_command([[highlight Hlargs guifg=#957FB8]])

      -- nordic
      -- vim.api.nvim_command([[highlight Hlargs guifg=#E7C173]])
    end,
  },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   opts = {
  --     statementStyle = { bold = false },
  --     fuctionStyle = { italic = true },
  --     transparent = true,
  --     colors = {
  --       theme = {
  --         wave = {},
  --         lotus = {},
  --         dragon = {},
  --         all = {
  --           ui = {
  --             bg_gutter = "none", -- 行番号の背景を透過にするため
  --           },
  --         },
  --       },
  --     },
  --     overrides = function(colors)
  --       local theme = colors.theme
  --       return {
  --         NormalFloat = { bg = "none" },
  --         FloatBorder = { bg = "none" },
  --         FloatTitle = { bg = "none" },
  --
  --         -- Save an hlgroup with dark background and dimmed foreground
  --         -- so that you can use it where your still want darker windows.
  --         -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
  --         NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
  --
  --         -- Popular plugins that open floats will link to NormalFloat by default;
  --         -- set their background accordingly if you wish to keep them dark and borderless
  --         LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --         MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --       }
  --     end,
  --   },
  -- },

  -- {
  --   "AlexvZyl/nordic.nvim",
  --   opts = {
  --     -- float border
  --     bright_border = true,
  --     after_palette = function(palette)
  --       local U = require("nordic.utils")
  --       palette.bg_visual = U.blend(palette.black0, palette.gray2, 0.3)
  --       -- palette.bg_visual = palette.gray4
  --     end,
  --     -- This callback can be used to override highlights before they are applied.
  --     on_highlight = function(highlights, palette)
  --       highlights.Comment = {
  --         fg = palette.gray5,
  --         italic = true,
  --       }
  --       highlights.Delimiter = {
  --         fg = palette.blue1,
  --       }
  --       highlights.bg_visual = {
  --         fg = palette.gray3,
  --         bg = palette.gray3,
  --       }
  --       highlights.fg_selected = {
  --         fg = palette.gray3,
  --         bg = palette.gray3,
  --       }
  --       highlights.bg_selected = {
  --         fg = palette.gray3,
  --         bg = palette.gray3,
  --       }
  --     end,
  --     transparent = {
  --       -- Enable transparent background.
  --       bg = true,
  --       -- Enable transparent background for floating windows.
  --       float = false,
  --     },
  --   },
  -- },
}
