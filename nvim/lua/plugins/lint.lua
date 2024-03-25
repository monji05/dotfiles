return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local sources = {
        null_ls.builtins.diagnostics.phpcs.with({
          extra_args = {
            "--standard=./phpcs_ruleset.xml",
          },
        }),
        null_ls.builtins.formatting.sql_formatter.with({
          extra_args = {
            "--config=/Users/erikomishina/.config/dotfiles/nvim/lua/plugins/sql_formatter/config.json",
          },
        }),
      }

      null_ls.setup({
        sources = sources,
      })
    end,
  },
}
