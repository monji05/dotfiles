require("mason-null-ls").setup({
  ensure_installed = {},
  automatic_installation = true,
  handlers = {},
})
require("mason").setup({
  automatic_installation = true,
})
local nls = require("null-ls")
nls.setup({
  root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
  sources = {
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
})
