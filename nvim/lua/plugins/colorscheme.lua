return {
  {
    "HoNamDuong/hybrid.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      require('hybrid').setup({
        transparent = true,
        bold = false,
         italic = {
          strings = false,
          emphasis = true,
          comments = true,
          folds = true,
        },
      })
      -- vim.cmd([[colorscheme hybrid]])
    end
  },
  {
    "https://github.com/vague-theme/vague.nvim",
    config = function ()
      require('vague').setup({
       transparent = true,
       bold = false,
       italic = false,
       colors = {
        bg = '#141415',
        inactiveBg = '#1c1c24',
        fg = '#cdcdcd',
        floatBorder = '#878787',
        line = '#252530',
        comment = '#606079',
        builtin = '#b4d4cf',
        func = '#c48282',
        string = '#e8b589',
        number = '#e0a363',
        property = '#c3c3d5',
        constant = '#aeaed1',
        parameter = '#bb9dbd',
        visual = '#333738',
        error = '#d8647e',
        warning = '#f3be7c',
        hint = '#7e98e8',
        operator = '#90a0b5',
        keyword = '#6e94b2',
        type = '#9bb4bc',
        search = '#405065',
        plus = '#7fa563',
        delta = '#f3be7c',
      },
      on_highlights = function (hl, c)
        hl.BlinkCmpMenuSelection = {
          -- darken color.comment
          bg ="#383848",
        }
        hl.CursorLineNr = {
          fg = c.number
        }

        -- 関数呼び出し(@function.call)を、関数定義(@function)の色にリンク
        hl["@function.call"] = { link = "@function" }

        -- メソッド呼び出し(@function.method.call)も、メソッド定義(@function.method)にリンク
        hl["@function.method.call"] = { link = "@function.method" }
      end,
      })
      -- vim.cmd([[colorscheme vague]])
    end
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    event = { "BufReadPre", "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {
      day_brightness = 0.5,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { italic = true },
        floats = "transparent",
        sidebars = "transparent",
      },

      ---@param colors ColorScheme
      on_colors = function(colors)
        colors.base0 = "#92a0a0"
      end,
      ---@param highlights Highlights
      ---@param colors ColorScheme
      on_highlights = function(hl, c)
        local number_fg = c.violet500
        -- hl["@number"] = {
        --   fg = number_fg,
        -- }
        -- hl.Number = {
        --   fg = number_fg,
        -- }
        -- hl["@lsp.type.number"] = {
        --   fg = number_fg,
        -- }
        -- hl.LspKindNumber = {
        --   fg = number_fg,
        -- }
        -- hl.LineNr = {
        --   fg = c.base01,
        --   -- bg = c.base02,
        -- }
        -- hl.CursorLineNr = {
        --   fg = c.yellow300,
        --   bg = c.yellow700,
        -- }
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
    config = function()
      vim.cmd([[colorscheme solarized-osaka]])
    end
  },
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup({})
      -- vague
      -- vim.api.nvim_command([[highlight Hlargs guifg=#bb9dbd]])

      -- rusty
      -- vim.api.nvim_command([[highlight Hlargs guifg=#b5bd68]])

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

      -- iceberg
      -- vim.api.nvim_command([[highlight Hlargs guifg=#a093c7]])

      -- nordic
      -- vim.api.nvim_command([[highlight Hlargs guifg=#E7C173]])
    end,
  },
}
