return {
  {
    "romgrk/barbar.nvim",
    keys = {
      { "<Tab>", "<Cmd>BufferNext<CR>" },
      { "<S-Tab>", "<Cmd>BufferPrevious<CR>" },
      { "<Leader><left>", "<Cmd>BufferMovePrevious<CR>" },
      { "<Leader><right>", "<Cmd>BufferMoveNext<CR>" },
      { "<Leader>P", "<Cmd>BufferPin<CR>" },
      { "<C-x>", "<Cmd>BufferClose<CR>" },
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
        highlight_visible = false,
        -- Disable highlighting alternate buffers
        highlight_alternate = false,
        icons = {
          -- modified = {
          --   button = "[+]",
          -- },
          pinned = { button = "", filename = true },
          button = "",
          -- Configure the base icons on the bufferline.
          -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
          buffer_index = true,
          buffer_number = false,
          -- Enables / disables diagnostic symbols
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = false, icon = icons.diagnostics.error },
            [vim.diagnostic.severity.WARN] = { enabled = false, icon = icons.diagnostics.warn },
            [vim.diagnostic.severity.INFO] = { enabled = false, icon = icons.diagnostics.info },
            [vim.diagnostic.severity.HINT] = { enabled = false, icon = icons.diagnostics.hint },
          },
          gitsigns = {
            added = { enabled = true, icon = icons.git.added },
            changed = { enabled = true, icon = icons.git.modified },
            deleted = { enabled = true, icon = icons.git.deleted },
          },
        },
      }

      -- vim.api.nvim_command([[highlight BufferCurrent  guifg=#002d38 guibg=#d33682]])
      vim.api.nvim_command([[highlight BufferCurrent  guifg=#dadada]])
      vim.api.nvim_command([[highlight BufferCurrentHint  guifg=#2aa198]])
      vim.api.nvim_command([[highlight BufferCurrentADDED  guifg=#719e07]])
      vim.api.nvim_command([[highlight BufferCurrentCHANGED  guifg=#b58900]])
      vim.api.nvim_command([[highlight BufferCurrentDELETED guifg=#b2555b]])
      vim.api.nvim_command([[highlight BufferCurrentSign  guifg=#719e07]])
      vim.api.nvim_command([[highlight BufferInactive guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveMod guifg=#6d72c5  guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveADDED guifg=#6d72c5 guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveCHANGED guifg=#6d72c5 guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveDELETED guifg=#6d72c5 guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveSign guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveERROR guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveWARN guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveINFO guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveHINT guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveIndex guibg=#002b36]])

      barbar.setup(opts)
    end,
  },
}
