local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.api.nvim_command([[
  syntax off
  filetype plugin indent off
  filetype off
]])

if not vim.loop.fs_stat(lazypath) then
  vim.fn
      .system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
      }, { text = true })
      :wait()
end

local plugins = {
  {
    "nvim-lua/popup.nvim",
    event = "BufRead",
    lazy = true,
  },
  {
    "nvim-lua/plenary.nvim",
    evet = { "BufReadPre", "BufNewFile" },
  },
  {
    "echasnovski/mini.nvim",
    lazy = true,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    ft = "typescript",
  },
  {
    "romgrk/barbar.nvim",
    config = function()
      require("plugins/barbar")
    end,
  },
  {
    "utilyre/barbecue.nvim",
    version = "*",
    name = "barbecue",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional dependency
      "SmiteshP/nvim-navic",
    },
    config = function()
      require("plugins/barbecue")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer",                     event = "InsertEnter" },
      { "roobert/tailwindcss-colorizer-cmp.nvim", event = "InsertEnter" },
      { "L3MON4D3/LuaSnip",                       event = "InsertEnter" },
    },
    event = { "InsertEnter" },
    config = function()
      require("plugins/cmp")
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("plugins/comment")
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("plugins/diffview")
    end,
  },
  {
    "gpanders/editorconfig.nvim",
    event = "BufReadPre",
  },
  {
    "ruifm/gitlinker.nvim",
    config = function()
      require("plugins/gitlinker")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead" },
    config = function()
      require("plugins/gitsigns")
    end,
  },
  {
    "anuvyklack/help-vsplit.nvim",
    event = "CmdlineEnter",
    config = function()
      require("help-vsplit").setup()
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("plugins/highlight-colors")
    end,
  },
  {
    "kevinhwang91/nvim-hlslens", -- show count result search word
    config = function()
      require("plugins/hlslens")
    end,
  },
  {
    "lewis6991/hover.nvim",
    keys = { "K", "GK" },
    config = function()
      require("plugins/hover")
    end,
  },
  {
    "RRethy/vim-illuminate",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    lazy = true,
    config = function()
      require("plugins/indentline")
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    config = function()
      require("plugins/lazygit")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins/lspconfig")
    end,
  },
  {
    "onsails/lspkind-nvim",
    event = "InsertEnter",
    config = function()
      require("plugins/lspkind")
    end,
  },
  {
    "kkharji/lspsaga.nvim",
    event = "LspAttach",
    opt = true,
    branch = "main",
    config = function()
      require("plugins/lspsaga")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      module = { "nvim-web-devicons" },
    },
    event = { "InsertEnter", "CursorHold", "FocusLost", "BufRead", "BufNewFile" },
    config = function()
      require("plugins/lualine")
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      -- require("plugins/luasnip")
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    module = { "mason" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        dependencies = "williamboman/mason-lspconfig.nvim",
        event = { "InsertEnter", "InsertLeave" },
      },
      { "jose-elias-alvarez/null-ls.nvim", event = { "BufReadPre", "BufNewFile" } },
    },
    config = function()
      require("plugins/mason-null-ls")
    end,
  },
  {
    "echasnovski/mini.align",
    cmd = "Ga",
    config = function()
      require("mini.align").setup()
    end,
  },
  {
    "echasnovski/mini.indentscope",
    config = function()
      require("plugins/mini-indentscope")
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "echasnovski/mini.splitjoin",
    cmd = "Gs",
    config = function()
      require("plugins/mini-splitjoin")
    end,
  },
  {
    "ecthelionvi/NeoComposer.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    event = "VeryLazy",
    config = function()
      require("plugins/neocomposer")
    end,
  },
  {
    "svrana/neosolarized.nvim",
    dependencies = { "tjdevries/colorbuddy.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins/neosolarized")
    end,
  },
  {
    "folke/noice.nvim",
    event = "BufEnter",
    module = "noice",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("plugins/noice")
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    config = function()
      require("plugins/obsidian")
    end,
  },
  {
    "potamides/pantran.nvim",
    config = function()
      require("plugins/pantran")
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      -- rename file
      require("plugins/scrollview")
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("plugins/surround")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-z.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "dawsers/telescope-file-history.nvim",
      "smartpde/telescope-recent-files",
    },
    keys = { ";f", ";r", "\\", ";;", "<leader>f", "<leader>z" },
    module = "Telescope",
    config = function()
      require("plugins/telescope")
    end,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugins/todo")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = "UIEnter",
    config = function()
      require("plugins/treesitter")
    end,
  },
  {
    "folke/trouble.nvim",
    keys = {
      "<leader>xx",
      "<leader>xw",
      "<leader>xd",
      "<leader>xl",
      "<leader>xq",
      "<leader>xd",
    },
    config = function()
      require("plugins/trouble")
    end,
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      require("plugins/vim-startuptime")
    end,
  },
  {
    "folke/which-key.nvim",
    keys = "<Leader>",
    config = function()
      require("which-key").setup({})
    end,
  },
}

vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins, {
  change_detection = {
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
  performance = {
    chache = {
      enabled = true,
    },
  },
  rtp = {
    disabled = {
      "gzip",
      "matchit",
      "matchparen",
      "netrwPlugin",
      "Jrplugin",
      "tarPlugin",
      "tohtml",
      "tutor",
      "zipPlugin",
    },
  },
  debug = false,
})
