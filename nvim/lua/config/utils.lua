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
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    ft = "typescript",
  },
  {
    "romgrk/barbar.nvim",
    event = "VimEnter",
    config = function()
      require("plugins/barbar")
    end,
  },
  {
    "utilyre/barbecue.nvim",
    version = "*",
    name = "barbecue",
    event = "BufReadPost",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
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
      { "hrsh7th/cmp-path",                       event = "InsertEnter" },
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
    lazy = true,
    event = { "CursorHold" },
    config = function()
      require("plugins/hlslens")
    end,
  },
  {
    "lewis6991/hover.nvim",
    keys = { "K", "gK" },
    config = function()
      require("plugins/hover")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = true,
    ft = { "lua", "php", "html", "css", "js", "jsx", "ts", "tsx", },
    config = function()
      require("plugins.indentline")
    end
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
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = function()
          require("plugins.mason")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "nvimdev/lspsaga.nvim",
        config = function()
          require("plugins.lspsaga")
        end,
      },
      {
        "hrsh7th/cmp-nvim-lsp",
      },
      {
        "SmiteshP/nvim-navbuddy",
        -- keys = { "<leader>nv", },
        cmd = "Navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      }
    },
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
    "rebelot/heirline.nvim",
    event = "UiEnter",
    config = function()
      require("plugins.heirline")
    end
  },
  {
    -- I won't use yet
    -- "L3MON4D3/LuaSnip",
    -- config = function()
    -- require("plugins/luasnip")
    -- end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,
    config = function()
      require("plugins.null-ls")
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
    "ecthelionvi/NeoComposer.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    event = "VeryLazy",
    config = function()
      require("plugins/neocomposer")
    end,
  },
  {
    -- "svrana/neosolarized.nvim",
    -- lazy = true,
    -- event = { "BufReadPost", "BufAdd", "BufNewFile" },
    -- dependencies = { "tjdevries/colorbuddy.nvim" },
    -- config = function()
    --   require("plugins/neosolarized")
    -- end,
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
    -- transration engine
    "potamides/pantran.nvim",
    config = function()
      require("plugins/pantran")
    end,
  },
  {
    'echasnovski/mini.surround',
    version = false,
    event = "VimEnter",
    config = function()
      require("plugins.mini-surround")
    end

  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-z.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "dawsers/telescope-file-history.nvim",
      "smartpde/telescope-recent-files",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    keys = { ";f", ";r", "\\", ";;", "<leader>f", "<leader>z" },
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
    lazy = true,
    build = function()
      if #vim.api.nvim_list_uis() ~= 0 then
        vim.api.nvim_command("TSUpdate")
      end
    end,
    event = { "BufAdd", "CursorHold", "CursorHoldI" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", },
      { "nvim-treesitter/nvim-treesitter-context", },
    },
    config = function()
      require("plugins/treesitter")
    end
  },
  {
    "folke/trouble.nvim",
    keys = {
      "<leader>tt",
      "<leader>tw",
      "<leader>td",
      "<leader>tl",
      "<leader>tq",
      "gR",
    },
    config = function()
      require("plugins/trouble")
    end
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      require("plugins/vim-startuptime")
    end
  },
  {
    "folke/which-key.nvim",
    keys = "<Leader>",
    config = function()
      require("which-key").setup({})
    end
  },
  {
    "RRethy/vim-illuminate",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    config = function()
      require("plugins.illuminate")
    end
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    'tomiis4/Hypersonic.nvim', -- interactive support for regexp
    event = "CmdlineEnter",
    cmd = "Hypersonic",
    config = function()
      require("plugins.hypersonic")
    end
  },
  {
    -- very useful join, split word in bracket, function
    "Wansmer/treesj",
    desc = "Toggle Treesitter Join",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = { use_default_keymaps = false },
  },
  {
    "f-person/git-blame.nvim",
    cmd = { "GitBlameCopyCommitURL", "GitBlameOpenCommitURL", "GitBlameCopyFileURL", "GitBlameToggle" },
    keys = {
      {
        "<leader>b",
        "<CMD>GitBlameToggle<CR>",
        desc = "toggle git blame"
      },
      {
        "<leader>gu",
        "<CMD>GitBlameCopyCommitURL<CR>",
        desc = "copy commit URL"
      },
      {
        "<leader>bf",
        "<CMD>GitBlameCopyFileURL<CR>",
        desc = "copy file URL"
      }
    },
    config = function()
      require("plugins.gitblame")
    end
  },
  {
    -- Convenience file operations for neovim
    "chrisgrieser/nvim-genghis",
    dependencies = "stevearc/dressing.nvim",
    config = function()
      require("plugins.genghis")
    end
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    ft = "norg",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "laher/neorg-exec" },
      { "nvim-neorg/neorg-telescope" },
      { "max397574/neorg-kanban" },
      { "max397574/neorg-contexts" },
      { "pysan3/neorg-templates" },
    },
    config = function()
      require("plugins.neorg")
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end
  },
  {
    "jbyuki/venn.nvim",
    config = function()
      require("plugins.venn")
    end
  },
  {
    "folke/tokyonight.nvim",
    config = function()
      local bg = "#011628"
      local bg_dark = "#011423"
      local bg_highlight = "#143652"
      local bg_search = "#0A64AC"
      local bg_visual = "#275378"
      local fg = "#CBE0F0"
      local fg_dark = "#B4D0E9"
      -- local fg_gutter = "#627E97"
      local border = "#547998"
      local gitSigns_add = "#6D955A"
      local gitSigns_change = "#978351"

      require("tokyonight").setup({
        style = "night",
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = bg_dark
          colors.bg_float = bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = bg_dark
          colors.bg_statusline = bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          -- colors.fg_float = fg
          -- colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
          colors.gitSigns.add = gitSigns_add
          colors.gitSigns.change = gitSigns_change
        end,

      })
      vim.api.nvim_command("colorscheme tokyonight")
    end
  },
  {
    'johnfrankmorgan/whitespace.nvim',
    config = function()
      require('whitespace-nvim').setup({
        -- configuration options and their defaults

        -- `highlight` configures which highlight is used to display
        -- trailing whitespace
        highlight = 'DiagnosticVirtualTextError',

        -- `ignored_filetypes` configures which filetypes to ignore when
        -- displaying trailing whitespace
        ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', "cmdline" },

        -- `ignore_terminal` configures whether to ignore terminal buffers
        ignore_terminal = true,
      })

      -- remove trailing whitespace with a keybinding
      -- vim.keymap.set('n', '<Leader>t', require('whitespace-nvim').trim)
    end
  }
}

vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins, {
  change_detection = {
    enabled = false,
    notify = false, -- get a notification when changes are found
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
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    colorscheme = { "catppuccin" },
  },
  debug = false,
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy/cache",
      -- Once one of the following events triggers, caching will be disabled.
      -- To cache all modules, set this to `{}`, but that is not recommended.
      disable_events = { "UIEnter", "BufReadPre" },
      ttl = 3600 * 24 * 2, -- keep unused modules for up to 2 days
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true,        -- reset the runtime path to $VIMRUNTIME and the config directory
      ---@type string[]
      paths = {},          -- add any custom paths here that you want to include in the rtp
    },
  },
})
