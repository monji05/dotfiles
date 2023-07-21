local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local nls = require("null-ls")
local utils = require("null-ls.utils")
nls.setup({
  root_dir = utils.root_pattern("composer.json", "package.json", ".null-ls-root", ".neoconf.json", "Makefile", ".git"), -- add composer
  diagnostics_format = "#{m} (#{c}) [#{s}]",
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
    -- php
    nls.builtins.diagnostics.phpcs.with({
      command = "./composer/bin/phpcs",
      args = {
        "--standard=./phpcs_ruleset.xml",
      },
    }),
    nls.builtins.formatting.phpcbf.with({
      command = "./composer/bin/phpcbf",
      args = {
        "--standard=PSR2",
      },
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
          -- vim.lsp.buf.formatting_sync()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})
