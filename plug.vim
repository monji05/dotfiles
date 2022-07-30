if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'pbrisbin/vim-mkdir'
Plug 'mhinz/vim-signify'
Plug 'tomtom/tcomment_vim'

if has("nvim")
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'onsails/lspkind-nvim'
  Plug 'tami5/lspsaga.nvim'
	Plug 'mfussenegger/nvim-jdtls'
  Plug 'eclipse/eclipse.jdt.ls'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'TimUntersberger/neogit'

  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'sindrets/diffview.nvim'

  Plug 'nvim-lua/completion-nvim'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'L3MON4D3/LuaSnip'

  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'ryanoasis/vim-devicons'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

  Plug 'hoob3rt/lualine.nvim'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'ntpeters/vim-better-whitespace'

  Plug 'cohama/lexima.vim'

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'lukas-reineke/indent-blankline.nvim'

  Plug 'RRethy/vim-illuminate'

  Plug 'vim-scripts/SingleCompile'

  Plug 'norcalli/nvim-colorizer.lua'
endif

call plug#end()
