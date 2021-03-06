if !exists('g:lspconfig')
    finish
end

lua << EOF
local nvim_lsp = require("lspconfig")
local protocol = require("vim.lsp.protocol")

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings
    local opts = {noremap = true, silent = true}
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

    if client.resolved_capabilities.document_formatting then
      vim.api.nvim_command [[augroup Format]]
      vim.api.nvim_command [[autocmd! * <buffer>]]
      vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
      vim.api.nvim_command [[augroup END]]
    end
end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

nvim_lsp.intelephense.setup {
    on_attach = on_attach,
    filetypes = {"php"},
    capabilities=capabilities
}

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    fileteyps = {"typescript", "typescriptreact", "typescript.tsx"},
    capabilities = capabilities
}


nvim_lsp.clangd.setup {
    on_attach = on_attach,
    fileteyps = {"cpp", "c++", "cc"},
    capabilities = capabilities
}

 nvim_lsp.jdtls.setup {
     on_attach = on_attach,
     filetypes = {"java"},
     capabilities = capabilities,
     root_dir = vim.loop.cwd
 }

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      prefix = '',
    }
  }
)
EOF
