vim.api.nvim_command([[highlight IblIndentHilight guifg=#3E4452 guibg=#000 gui=nocombine]])
local ibl = require("ibl").setup({
  indent = {
    char = "▏",
    tab_char = "|",
    highlight = "IblIndentHilight",
  },
  whitespace = {
    -- remove_blankline_trail = false,
    remove_blankline_trail = true,
    highlight = "IblIndentHilight",
  },
  scope = {
    -- don't be true! tree-sitter cause error!
    enabled = false,
  },
  exclude = {
    filetypes = {
      "help",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
    },
    buftypes = {
      "terminal",
      "nofile",
    },
  },
})
