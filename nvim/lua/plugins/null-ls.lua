return {
  'jose-elias-alvarez/null-ls.nvim', --  Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  event = 'BufEnter',
  config = function()
    local status, null_ls = pcall(require, "null-ls")
    if (not status) then return end

    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.eslint_d.with({
          diagnostics_format = '[eslint] #{m}\n(#{c})'
        }),
      }
    })
  end
}
