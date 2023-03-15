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
  {
    'svrana/neosolarized.nvim',
    dependencies = { 'tjdevries/colorbuddy.nvim', lazy = true },
  },
  { 'nvim-lualine/lualine.nvim', lazy = true }, -- Statusline
  { 'nvim-lua/popup.nvim',       lazy = true },
  { 'onsails/lspkind-nvim',      lazy = true }, -- vscode-like pictograms
  { 'hrsh7th/cmp-nvim-lsp', }, -- nvim-cmp source for neovim's built-in LSP
  { 'hrsh7th/nvim-cmp', -- Completion
    dependencies = 'hrsh7th/cmp-buffer',
  },
  { 'neovim/nvim-lspconfig',             lazy = true }, -- LSP
  { 'williamboman/mason.nvim',           lazy = true },
  { 'williamboman/mason-lspconfig.nvim', lazy = true },
  { 'jose-elias-alvarez/null-ls.nvim',   lazy = true }, --  Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua

  { 'glepnir/lspsaga.nvim',              lazy = true }, -- LSP UIs
  { 'L3MON4D3/LuaSnip',                  lazy = true },
  { 'nvim-treesitter/nvim-treesitter',   lazy = true },
  { 'windwp/nvim-ts-autotag',            lazy = true },
  { 'kyazdani42/nvim-web-devicons',      lazy = true }, -- File icons
  {
    'nvim-telescope/telescope.nvim',
    keys = { ';f', ';r', '\\', ';;', lazy = true },
    dependencies = "nvim-telescope/telescope-file-browser.nvim"
  },
  { 'windwp/nvim-autopairs',               lazy = true },
  { 'norcalli/nvim-colorizer.lua',         lazy = true },
  { 'lewis6991/gitsigns.nvim',             lazy = true }, -- Git diff marker
  { 'akinsho/nvim-bufferline.lua',         lazy = true },
  { 'RRethy/vim-illuminate',               lazy = true }, -- highlight on current cursol word
  { 'lukas-reineke/indent-blankline.nvim', lazy = true }, -- indent line
  { 'numToStr/Comment.nvim',               lazy = true }, --comment
  { 'kevinhwang91/nvim-hlslens',           lazy = true }, -- show count result search word
  {
    'TimUntersberger/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    lazy = true
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = { "fi" },
    branch = "v2.x",
    dependencies = {
      "MunifTanjim/nui.nvim",

    },
    lazy = true
  },
  {
    'kylechui/nvim-surround',
    version = "*",
  },
  {
    'davidgranstrom/nvim-markdown-preview',
    ft = { 'markdown' },
    lazy = true
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = true
  }
})
