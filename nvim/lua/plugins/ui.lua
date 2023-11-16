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
}
