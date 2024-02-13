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
      }

      null_ls.setup({
        sources = sources,
      })
    end,
  },
}
