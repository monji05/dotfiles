return {
  { 'nvim-lua/popup.nvim',
    event = 'BufRead',
    lazy = true
  },
  { "nvim-lua/plenary.nvim",
    lazy = false
  },
  {
    'hrsh7th/cmp-nvim-lsp', -- nvim-cmp source for neovim's built-in LSP
    dependencies = "nvim-cmp"
  },
}
