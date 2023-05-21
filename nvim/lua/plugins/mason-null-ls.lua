return {
  "jay-babu/mason-null-ls.nvim",
  -- event = { "InsertEnter" },
  dependencies = {
    { "williamboman/mason.nvim",         dependencies = "williamboman/mason-lspconfig.nvim", cmd = { "Mason" } },
    { "jose-elias-alvarez/null-ls.nvim", cmd = { "W" } },
  },
  config = function()
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
    })
  end,
}
