return {
  -- {
  --   "https://github.com/mofiqul/vscode.nvim",
  --   config = function()
  --     require("vscode").setup({
  --       transparent = true,
  --     })
  --     vim.cmd([[colorscheme vscode]])
  --   end,
  -- },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    event = { "BufReadPre", "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {
      style = "vivid",
      vivid_brightness = 0.3,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { italic = true },
        floats = "transparent",
        sidebars = "transparent",
      },

      ---@param colors ColorScheme
      on_colors = function(colors)
        -- colors.base0 = "#92a0a0"
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
        hl.LineNr = {
          fg = c.base01,
          -- bg = c.base02,
        }
        hl.CursorLineNr = {
          fg = c.green500,
          bg = c.green900,
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
    config = function(_, opts)
      require("solarized-osaka").setup(opts)
      vim.cmd([[colorscheme solarized-osaka]])
    end,
  },
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup({})
      -- 引数（パラメータ）に使われるハイライトグループの候補（優先順）
      local param_groups = {
        "@variable.parameter", -- Treesitter（Neovim 0.9+ 標準）
        "@lsp.type.parameter", -- LSP Semantic Tokens
        "@parameter", -- 旧 Treesitter 互換用
        "Identifier", -- Vim標準フォールバック
      }

      local fg_color = nil

      for _, group_name in ipairs(param_groups) do
        local hl = vim.api.nvim_get_hl(0, { name = group_name, link = false })
        if hl and hl.fg then
          fg_color = hl.fg
          break
        end
      end

      if fg_color then
        vim.api.nvim_set_hl(0, "Hlargs", { fg = string.format("#%06x", fg_color) })
      end
      -- vague
      -- vim.api.nvim_command([[highlight Hlargs guifg=#bb9dbd]])

      -- rusty
      -- vim.api.nvim_command([[highlight Hlargs guifg=#b5bd68]])

      -- solarized-osaka
      -- vim.api.nvim_command([[highlight Hlargs guifg=#db4b4b]])

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

      -- vscode
      -- vim.api.nvim_command([[highlight Hlargs guifg=#F97583]])
    end,
  },
}
