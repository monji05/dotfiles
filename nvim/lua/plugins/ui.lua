return {
  {
    "romgrk/barbar.nvim",
    event = "InsertLeave",
    keys = {
      { "<Tab>", "<Cmd>BufferNext<CR>" },
      { "<S-Tab>", "<Cmd>BufferPrevious<CR>" },
      { "<Leader><left>", "<Cmd>BufferMovePrevious<CR>" },
      { "<Leader><right>", "<Cmd>BufferMoveNext<CR>" },
      { "<Leader>P", "<Cmd>BufferPin<CR>" },
      { "<Leader>x", "<Cmd>BufferClose<CR>" },
      { "<S-x>", "<Cmd>BufferRestore<CR>" },
      { "<Leader>p", "<Cmd>BufferPick<CR>" },
      { "<Leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>" },
      { "<Leader>bd", "<Cmd>BufferOrderByDirectory<CR>" },
      { "<Leader>bl", "<Cmd>BufferOrderByLanguage<CR>" },
      { "<Leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>" },
    },
    config = function()
      local icons = require("lazyvim.config").icons
      local barbar = require("barbar")
      local opts = {
        -- Enable highlighting visible buffers
        highlight_visible = true,
        -- Disable highlighting alternate buffers
        highlight_alternate = false,
        icons = {
          pinned = { button = "", filename = true },
          button = "",
          -- Configure the base icons on the bufferline.
          -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
          buffer_index = false,
          buffer_number = false,
          -- Enables / disables diagnostic symbols
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = true, icon = icons.diagnostics.error },
            [vim.diagnostic.severity.WARN] = { enabled = true, icon = icons.diagnostics.warn },
            [vim.diagnostic.severity.INFO] = { enabled = true, icon = icons.diagnostics.info },
            [vim.diagnostic.severity.HINT] = { enabled = true, icon = icons.diagnostics.hint },
          },
          gitsigns = {
            added = { enabled = true, icon = icons.git.added },
            changed = { enabled = true, icon = icons.git.modified },
            deleted = { enabled = true, icon = icons.git.deleted },
          },
        },
      }
      -- highlight
      vim.api.nvim_command([[highlight BufferCurrent  guifg=#dadada]])
      vim.api.nvim_command([[highlight BufferCurrentHint  guifg=#2aa198]])
      vim.api.nvim_command([[highlight BufferCurrentADDED  guifg=#719e07]])
      vim.api.nvim_command([[highlight BufferCurrentCHANGED  guifg=#b58900]])
      vim.api.nvim_command([[highlight BufferCurrentDELETED guifg=#b2555b]])
      vim.api.nvim_command([[highlight BufferCurrentSign  guifg=#719e07]])
      vim.api.nvim_command([[highlight BufferInactive guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveMod  guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveADDED guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveCHANGED guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveDELETED guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveSign guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveERROR guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveWARN guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveINFO guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveHINT guibg=#002b36]])
      barbar.setup(opts)
    end,
  },
  {
    "lewis6991/hover.nvim",
    keys = {
      "<Leader>K",
      "<Leader>gK",
    },
    config = function()
      require("hover").setup({
        init = function()
          -- Require providers
          -- require("hover.providers.lsp")
          -- require("hover.providers.gh")
          -- require("hover.providers.gh_user")
          -- require('hover.providers.jira')
          -- require("hover.providers.man")
          require("hover.providers.dictionary")
        end,
        preview_opts = {
          border = nil,
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
      })

      -- Setup keymaps
      vim.keymap.set("n", "<Leader>K", require("hover").hover, { desc = "hover.nvim" })
      vim.keymap.set("n", "<Leader>gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
    end,
  },
  {
    "folke/noice.nvim",
    event = "BufEnter",
    module = "noice",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {
      cmdline = {
        format = {
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "folke/neodev.nvim",
    },
    keys = {
      "<F5>",
      "<F6>",
      "<F10>",
      "<F12>",
      "<leader>db",
      "<leader>dr",
      "<leader>dl",
      "<leader>tu",
    },
    config = function()
      local dap = require("dap")
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
      }

      dap.configurations.php = {
        {
          name = "OfferBox v1",
          type = "php",
          request = "launch",
          port = 9000,
          pathMappings = {
            ["/var/www/offerbox"] = "${workspaceFolder}",
          },
        },
        {
          name = "OfferBox v2",
          type = "php",
          request = "launch",
          port = 9000,
          pathMappings = {
            ["/var/www/offerbox/offerbox-v2"] = "${workspaceFolder}/offerbox-v2",
          },
        },
      }

      vim.api.nvim_set_keymap("n", "<F5>", ":DapContinue<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<F6>", ":DapStepInto<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<F10>", ":DapStepOver<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<F12>", ":DapStepOut<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dr", ':lua require("dap").repl.open()<CR>', { silent = true })
      vim.api.nvim_set_keymap("n", "<leader>dl", ':lua require("dap").run_last()<CR>', { silent = true })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("dapui").setup({
        ---@diagnostic disable-next-line: missing-fields
        icons = { expanded = "", collapsed = "" },
        layouts = {
          {
            elements = {
              { id = "watches", size = 0.20 },
              { id = "stacks", size = 0.20 },
              { id = "breakpoints", size = 0.20 },
              { id = "scopes", size = 0.40 },
            },
            size = 50,
            position = "right",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.20,
            position = "bottom",
          },
        },
      })
      vim.api.nvim_set_keymap("n", "<leader>tu", "<Cmd>lua require('dapui').toggle()<CR>", { silent = true })
    end,
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        center = {
          { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
          { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
          { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
          { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
          {
            action = [[lua require("lazyvim.util").telescope.config_files()()]],
            desc = " Config",
            icon = " ",
            key = "c",
          },
          { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
          { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
          { action = "qa", desc = " Quit", icon = " ", key = "q" },
        },
      },
    },
  },
}
