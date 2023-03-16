local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  cache_enabled = true,
  {
    'svrana/neosolarized.nvim',
    dependencies = { 'tjdevries/colorbuddy.nvim' },
    lazy = false
  },
  { 'nvim-lualine/lualine.nvim', event = 'BufNewfile, BufRead', lazy = true }, -- Statusline
  { 'nvim-lua/popup.nvim',       event = 'BufNewfile, BufRead' },
  { 'onsails/lspkind-nvim',      event = 'LspAttach' }, -- vscode-like pictograms
  { 'hrsh7th/cmp-nvim-lsp', }, -- nvim-cmp source for neovim's built-in LSP
  { 'hrsh7th/nvim-cmp', -- Completion
    dependencies = 'hrsh7th/cmp-buffer',
  },
  { 'neovim/nvim-lspconfig',             event = 'LspAttach' }, -- LSP
  { 'williamboman/mason.nvim',           event = 'CmdlineEnter' },
  { 'williamboman/mason-lspconfig.nvim', event = 'CmdlineEnter' },
  { 'jose-elias-alvarez/null-ls.nvim',   event = 'BufRead' }, --  Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  { 'glepnir/lspsaga.nvim',              event = 'LspAttach' }, -- LSP UIs
  { 'L3MON4D3/LuaSnip',                  event = 'InsertEnter' },
  { 'nvim-treesitter/nvim-treesitter',   event = 'VeryLazy' },
  { 'windwp/nvim-ts-autotag',            event = 'InsertEnter' },
  { 'kyazdani42/nvim-web-devicons',      event = 'BufRead' }, -- File icons
  {
    'nvim-telescope/telescope.nvim',
    keys = { ';f', ';r', '\\', ';;' },
    cmd = 'Telescope',
    dependencies = "nvim-telescope/telescope-file-browser.nvim"
  },
  { 'windwp/nvim-autopairs',               event = 'ModeChanged' },
  { 'norcalli/nvim-colorizer.lua',         event = 'BufRead' },
  { 'lewis6991/gitsigns.nvim',             event = 'BufRead' }, -- Git diff marker
  { 'akinsho/nvim-bufferline.lua',         event = 'BufRead' },
  { 'lukas-reineke/indent-blankline.nvim', event = 'BufRead' }, -- indent line
  { 'numToStr/Comment.nvim',               keys = { '<C-u>', '<C-y>' } }, --comment
  { 'kevinhwang91/nvim-hlslens',           event = 'CmdlineEnter' }, -- show count result search word
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Fi",
    branch = "v2.x",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = 'VeryLazy'
  },
  {
    'kylechui/nvim-surround',
    version = "*",
    event = 'ModeChanged'
  },
  {
    'davidgranstrom/nvim-markdown-preview',
    ft = 'markdown',
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", lazy = false },
    event = 'BufRead'
  }
})
