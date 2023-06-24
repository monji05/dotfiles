require("illuminate").configure({
  providers = {
    "lsp",
    "treesitter",
    "regex",
  },
  delay = 100,
  filetypes_denylist = {
    "DoomInfo",
    "DressingSelect",
    "NvimTree",
    "Outline",
    "TelescopePrompt",
    "Trouble",
    "alpha",
    "dashboard",
    "dirvish",
    "fugitive",
    "help",
    "lsgsagaoutline",
    "neogitstatus",
    "norg",
    "toggleterm",
  },
  under_cursor = false,
})
vim.api.nvim_command([[highlight IlluminatedWordText guibg=#002B36 gui=NONE]])
vim.api.nvim_command([[highlight IlluminatedWordRead guibg=#002B36 gui=NONE]])
vim.api.nvim_command([[highlight IlluminatedWordWrite guibg=#002B36 gui=NONE]])
