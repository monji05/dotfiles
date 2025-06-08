---@diagnostic disable: missing-fields
return {
  {
    "numToStr/Comment.nvim",
    keys = { "<leader>u", "gc" },
    config = function()
      require("Comment").setup({
        toggler = {
          line = "<leader>u",
          block = "gc",
        },
      })
    end,
  },
  {
    "weirongxu/plantuml-previewer.vim",
    { "tyru/open-browser.vim", lazy = true },
    { "aklt/plantuml-syntax", lazy = true },
    ft = "plantuml",
    cmd = { "PlantumlOpen", "PlantumlStart", "PlantumlSave" },
  },
  {
    "williamboman/mason.nvim",
    keys = { "Mason", "MaonsInstall" },
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "cspell",
        "markdownlint",
        "markdown-toc",
        "intelephense",
        "lua-language-server",
        "tailwindcss-language-server",
      })
    end,
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recommended as each new version will have breaking changes
    opts = {
      bs = { -- *ultimate-autopair-map-backspace-config*
        single_delete = true,
        -- <!--|--> > bs > <!-|
      },
    },
  },
  {
    "nvim-neotest/neotest",
    cmd = { "Neotest" },
    { "nvim-neotest/nvim-nio", lazy = true },
    { "nvim-lua/plenary.nvim", lazy = true },
    { "antoinemadec/FixCursorHold.nvim", lazy = true },
    { "nvim-treesitter/nvim-treesitter", lazy = true },
    { "olimorris/neotest-phpunit", lazy = true },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-phpunit"),
        },
      })
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    keys = {
      "co",
      "ct",
      "cb",
      "c0",
      "]x",
      "[x",
    },
    -- co — choose ours
    -- ct — choose theirs
    -- cb — choose both
    -- c0 — choose none
    -- ]x — move to previous conflict
    -- [x — move to next conflict
    version = "*",
    config = true,
  },
  {
    "monaqa/dial.nvim",
    keys = {
      {
        "g+",
        function()
          require("dial.map").manipulate("increment", "normal")
        end,
      },
      {
        "g-",
        function()
          require("dial.map").manipulate("decrement", "normal")
        end,
      },
      {
        "g<C-a>",
        function()
          require("dial.map").manipulate("increment", "gnormal")
        end,
      },
      {
        "g<C-x>",
        function()
          require("dial.map").manipulate("decrement", "gnormal")
        end,
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          augend.constant.alias.bool, -- boolean value (true <-> false)
          augend.constant.new({ -- && <-> ||
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          }),
        },
      })
    end,
  },
  {
    ---@class wk.Opts
    "folke/which-key.nvim",
    keys = { "<leader>" },
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "helix",
    },
  },
}
