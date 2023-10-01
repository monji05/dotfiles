local ibl = require("ibl").setup {
  indent = {
    char = "▏",
  },
  whitespace = {
    remove_blankline_trail = false,
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
    }
  },
  smart_indent_cap = true
}

vim.opt.listchars:append("tab:»-")
