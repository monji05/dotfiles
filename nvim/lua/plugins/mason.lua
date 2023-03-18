return {
  'williamboman/mason.nvim',
  dependencies = { 'williamboman/mason-lspconfig.nvim', cmd = 'Mason' },
  module = 'mason',
  config = function()
    local status, mason = pcall(require, 'mason')
    if (not status) then return end
    local status2, lspconfig = pcall(require, 'mason-lspconfig')
    if (not status2) then return end

    mason.setup({})

    lspconfig.setup {
      automatic_installation = true,
    }
  end
}
