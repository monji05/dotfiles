local diagnostics = require("config.icons").get("diagnostics")
local git = require("config.icons").get("git")
require("barbar").setup({
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
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = diagnostics.error },
      [vim.diagnostic.severity.WARN] = { enabled = true, icon = diagnostics.warn },
      [vim.diagnostic.severity.INFO] = { enabled = true, icon = diagnostics.info },
      [vim.diagnostic.severity.HINT] = { enabled = true, icon = diagnostics.hint },
    },
    gitsigns = {
      added = { enabled = true, icon = git.add },
      changed = { enabled = true, icon = git.changedelete },
      deleted = { enabled = true, icon = git.delete },
    },
  },
})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("n", "<Tab>", "<Cmd>BufferNext<CR>", opts)
map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<Leader><left>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<Leader><right>", "<Cmd>BufferMoveNext<CR>", opts)
map("n", "<Leader>P", "<Cmd>BufferPin<CR>", opts)
map("n", "<Leader>x", "<Cmd>BufferClose<CR>", opts)
map("n", "<S-x>", "<Cmd>BufferRestore<CR>", opts)
map("n", "<Leader>p", "<Cmd>BufferPick<CR>", opts)
map("n", "<Leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
map("n", "<Leader>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
map("n", "<Leader>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
map("n", "<Leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

--highlight
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
