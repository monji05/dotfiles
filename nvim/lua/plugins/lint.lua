return {
  {
    -- "nvimtools/none-ls.nvim",
    -- config = function()
    --   local null_ls = require("null-ls")
    --   local sources = {
    --     null_ls.builtins.diagnostics.phpcs.with({
    --       extra_args = {
    --         "--standard=./phpcs_ruleset.xml",
    --       },
    --     }),
    --     null_ls.builtins.formatting.sql_formatter.with({
    --       extra_args = {
    --         "--config=/Users/erikomishina/.config/dotfiles/nvim/lua/plugins/sql_formatter/config.json",
    --       },
    --     }),
    --   }
    --
    --   null_ls.setup({
    --     sources = sources,
    --   })
    -- end,
  },
  {
    -- "mfussenegger/nvim-lint",
    -- opts = {
    --   linters_by_ft = {
    --     -- php = { "phpstan" },
    --     php = { "phpcs" },
    --   },
    -- },
    -- config = function()
    --   local lint = require("lint")
    --   lint.linters.phpcs = {
    --     args = {
    --       "--standard=./phpcs_ruleset.xml",
    --       "-s",
    --       "-p",
    --     },
    --   }
    --   -- lint.linters.phpstan = {
    --   --   args = {
    --   --     "analyze",
    --   --     "--memory-limit=2G",
    --   --   },
    --   -- }
    -- end,
  },
}
