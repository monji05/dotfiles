return {
  {
    "mfussenegger/nvim-lint",
    init = function()
      local lint = require("lint")
      local phpcs = lint.linters.phpcs
      phpcs.cmd = "phpcs"
      phpcs.stdin = true
      phpcs.args = {
        "-q",
        "--standard=/Users/erikomishina/www/offerbox/public_html/phpcs_ruleset.xml",
        "--report=json",
      }

      local phpstan = lint.linters.phpstan
      phpstan.cmd = "/Users/erikomishina/www/offerbox/public_html/offerbox-v2/vendor/bin/phpstan"
      phpstan.args = {
        "analyse",
        "--level=9",
        "--memory-limit=2G",
        "--configuration=/Users/erikomishina/www/offerbox/public_html/offerbox-v2/phpstan.neon.dist",
        "--error-format=json",
        -- "-c", 省略形にしても動かない
        -- "./phpstan.neon.dist",
      }

      lint.linters_by_ft = {
        php = { "phpcs", "cspell" },
        -- php = { "phpcs", "phpstan", "cspell" }, -- プロジェクトのneon.distが読み込めないせいで、無駄なエラーがでてノイズなので一旦ストップ
        javascript = { "eslint_d", "cspell" },
        typescript = { "eslint_d", "cspell" },
        javascriptreact = { "eslint_d", "cspell" },
        typescriptreact = { "eslint_d", "cspell" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
        callback = function()
          lint.try_lint()
        end,
      })
      local ns = lint.get_namespace("phpstan")
      vim.diagnostic.config({ virtual_text = true }, ns)
    end,
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   config = function()
  --     local null_ls = require("null-ls")
  --     local phpstan = null_ls.builtins.diagnostics.phpstan
  --     phpstan.command = "/Users/erikomishina/www/offerbox/public_html/vendor/bin/phpstan" --  fullpath phpstan command
  --     phpstan.args = {
  --       "analyse",
  --       "--memory-limit=2G",
  --       "-l",
  --       "9",
  --       "-c",
  --       "/Users/erikomishina/www/offerbox/public_html/offerbox-v2/phpstan.neon.dist", -- full path neon or neon.dist
  --       "$FILENAME",
  --     }
  --   end,
  -- },
}
