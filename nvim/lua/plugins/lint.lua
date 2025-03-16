return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    -- PHP
    -- local phpcs = lint.linters.phpcs
    -- phpcs.cmd = "vendor/bin/phpcs"
    -- phpcs.stdin = false
    -- phpcs.args = {
    --   "--standard=PSR12",
    --   "--report=json",
    --   "-q",
    -- }
    --
    -- lint.linters_by_ft = {
    --   php = { "phpcs" },
    -- }
    --

    local phpstan = lint.linters.phpstan

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local phpstan = null_ls.builtins.diagnostics.phpstan
      phpstan.command = "..." --  fullpath phpstan command
      phpstan.args = {
        "analyse",
        "--memory-limit=2G",
        "-l",
        "9",
        "-c",
        "neon.dist", -- full path neon or neon.dist
        "$FILENAME",
      }
    end,
  },
}
