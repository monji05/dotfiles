---@diagnostic disable: missing-fields
return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        toggler = {
          line = "<C-u>",
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
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    ft = "norg",
    dependencies = {
      {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- We'd like this plugin to load first out of the rest
        config = true, -- This automatically runs `require("luarocks-nvim").setup()`
      },
      { "nvim-lua/plenary.nvim" },
      { "laher/neorg-exec" },
      { "nvim-neorg/neorg-telescope" },
      { "max397574/neorg-contexts" },
      { "pysan3/neorg-templates" },
    },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                neorg_notes = "~/neorg_notes",
              },
              default_workspace = "neorg_notes",
            },
          },
          ["core.export"] = {
            config = {
              public = {
                export_dir = "output",
              },
            },
          },
          ["external.exec"] = {},
          ["external.context"] = {},
          ["external.templates"] = {
            config = {
              templates_dir = "~/neorg_notes/templates",
            },
          },
          ["core.completion"] = {
            config = { engine = "nvim-cmp" },
          },
          ["core.integrations.nvim-cmp"] = {},
          ["core.qol.todo_items"] = {},
          -- ["core.integrations.telescope"] = {},
          -- ["core.tempus"] = {},
          -- ["core.ui.calendar"] = {}, required neovim +10.0.0
        },
      })

      local neorg_callbacks = require("neorg.core.callbacks")

      ---@diagnostic disable-next-line: missing-parameter
      neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
          -- n = { -- Bind keys in normal mode
          --   { "<C-F>", "core.integrations.telescope.find_linkable" },
          -- },

          i = { -- Bind in insert mode
            { "<C-p>", "core.integrations.telescope.insert_link" },
          },
        }, {
          silent = true,
          noremap = true,
        })
      end)
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
    "nomnivore/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- All the user commands added by the plugin
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
    -- Sample keybind for prompting. Note that the <c-u> is important for selections to work properly.
    keys = {
      {
        "<leader>oo",
        ":<c-u>lua require('ollama').prompt()<cr>",
        desc = "ollama prompt",
        mode = { "n", "v" },
      },
    },
    opts = {
      model = "llama2",
    },
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
    branch = "v0.6", --recomended as each new version will have breaking changes
    opts = {
      bs = { -- *ultimate-autopair-map-backspace-config*
        single_delete = true,
        -- <!--|--> > bs > <!-|
      },
    },
  },
  {
    "nvim-neotest/neotest",
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
    version = "*",
    config = true,
  },
}
