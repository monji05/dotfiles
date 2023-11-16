return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    -- PHP
    local phpcs = lint.linters.phpcs
    phpcs.cmd = "vendor/bin/phpcs"
    -- phpcs.stdin = false
    phpcs.args = {
      "--standard=PSR12",
      "--report=json",
      "-q",
    }

    lint.linters_by_ft = {
      php = { "phpcs" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
