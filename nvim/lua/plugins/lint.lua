return {
  {
    "mfussenegger/nvim-lint",
    init = function()
      local lint = require("lint")
      local phpcs = lint.linters.phpcs
      phpcs.cmd = "phpcs"
      phpcs.stdin = true
      phpcs.args = {
        "--standard=/Users/erikomishina/www/offerbox/public_html/phpcs_ruleset.xml",
        "--report=json",
      }

      local phpstan = lint.linters.phpstan
      phpstan.cmd = "./offerbox-v2/vendor/bin/phpstan"
      phpstan.args = {
        "analyse",
        "--level=9",
        "--memory-limit=2G",
        "--error-format=json",
        -- "-c",
        -- "./phpstan.neon.dist",
      }

      lint.linters_by_ft = {
        -- php = { "phpcs", "phpstan" },
        php = { "phpcs" }, -- プロジェクトのneon.distが読み込めないせいで、無駄なエラーがでてノイズなので一旦ストップ
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
