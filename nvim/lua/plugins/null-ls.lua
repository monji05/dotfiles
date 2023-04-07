return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile", "BufRead" },
  opts = function()
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {
        -- markdown
        nls.builtins.formatting.markdownlint,
        -- fish
        nls.builtins.formatting.fish_indent,
        nls.builtins.diagnostics.fish,
        -- lua
        nls.builtins.formatting.stylua,
        -- shell
        nls.builtins.formatting.shfmt,
        -- python
        nls.builtins.diagnostics.flake8,
      },
    }
  end,
}
