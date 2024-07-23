return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      local phpcs = lint.linters.phpcs
      phpcs.cmd = "phpcs"
      phpcs.stdin = true
      phpcs.args = {
        "--standard=/Users/erikomishina/www/offerbox/public_html/phpcs_ruleset.xml",
        "--report=json",
      }

      lint.linters_by_ft = {
        php = { "phpcs" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
