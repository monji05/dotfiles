---@diagnostic disable: missing-fields
return {
  {
    "numToStr/Comment.nvim",
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
    -- Convenience file operations for neovim
    "chrisgrieser/nvim-genghis",
    dependencies = "stevearc/dressing.nvim",
    config = function()
      local keymap = vim.keymap.set
      local genghis = require("genghis")
      keymap("n", "<leader>yp", genghis.copyFilepath)
      keymap("n", "<leader>yn", genghis.copyFilename)
      -- keymap("n", "<leader>cx", genghis.chmodx)
      keymap("n", "<leader>rf", genghis.renameFile)
      keymap("n", "<leader>mf", genghis.moveAndRenameFile)
      keymap("n", "<leader>nf", genghis.createNewFile)
      keymap("n", "<leader>yf", genghis.duplicateFile)
      -- keymap("n", "<leader>df", function() genghis.trashFile { trashLocation = "your/path" } end) -- default: "$HOME/.Trash".
      -- keymap("x", "<leader>x", genghis.moveSelectionToNewFile)
    end,
  },
  {
    "weirongxu/plantuml-previewer.vim",
    dependencies = {
      "tyru/open-browser.vim",
      "aklt/plantuml-syntax",
    },
    ft = "plantuml",
    cmd = { "PlantumlOpen", "PlantumlStart", "PlantumlSave" },
  },
  {
    "williamboman/mason.nvim",
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
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "lukas-reineke/cmp-rg",
    },
    opts = function()
      require("cmp").setup({
        sources = {
          {
            name = "rg",
          },
        },
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
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-phpunit",
    },
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
    "toppair/peek.nvim",
    ft = { "markdown" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
}
