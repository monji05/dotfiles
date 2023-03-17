return {
  'glepnir/lspsaga.nvim', -- LSP UIs
  event = 'LspAttach',
  lazy = true,
  config = function()
    local status, saga = pcall(require, "lspsaga")
    if (not status) then return end

    saga.setup {
      server_filetype_map = {
        typescript = 'typescript'
      },
      ui = {
        winblend = 10,
        border = 'rounded',
        colors = {
          normal_bg = '#002b36'
        }
      }
    }

    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<Space>j', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
    vim.keymap.set('n', 'gh', '<Cmd>Lspsaga hover_doc<CR>', opts)
    vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
    -- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
    vim.keymap.set('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', opts)
    vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>', opts)
    vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename ++project<CR>', opts)
  end
}
