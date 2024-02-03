return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    -- PHP
    local phpcs = lint.linters.phpcs
    phpcs.cmd = "vendor/bin/phpcs"
    -- phpcs.stdin = false
    phpcs.args = {
      "--standard=./phpcs_ruleset.xml",
      "--report=json",
      "-q",
    }

    -- cpelll
    local cspell = lint.linters.cspell
    cspell.args = { "--config=~/.config/cspell/cspell.json" }

    lint.linters_by_ft = {
      php = { "phpcs", "cspell" },
      lua = { "cspell" },
      markdown = { "cspell" },
      neorg = { "cspell" },
      json = { "cspell" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
