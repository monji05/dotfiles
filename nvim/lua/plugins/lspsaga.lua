local diagnostics = require("config.icons").get("diagnostics")

require("lspsaga").setup({
  debug = false,
  -- for disable phpactor code_action
  lightbulb = {
    enable = false,
  },
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = diagnostics.error,
  warn_sign = diagnostics.warn,
  hint_sign = diagnostics.hint,
  infor_sign = diagnostics.info,
  diagnostic_header_icon = diagnostics.header,
  code_action_prompt = {
    enable = false,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = diagnostics.finder_definition,
  finder_reference_icon = diagnostics.finder_reference,
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },
  definition_preview_icon = diagnostics.preview,
  border_style = "single",
  rename_prompt_prefix = diagnostics.rename_prompt_prefix,
  rename_output_qflist = {
    enable = true,
    auto_open_qflist = true,
  },
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  diagnostic_message_format = "%m %c",
  highlight_prefix = false,
})

local opt = { silent = true, noremap = true }
vim.keymap.set("n", "gd", "<CMD>Lspsaga goto_definition<CR>", opt)
vim.keymap.set("n", "gf", "<CMD>Lspsaga finder<CR>", opt)
vim.keymap.set("n", "gh", "<CMD>Lspsaga hover_doc<CR>", opt)
vim.keymap.set("n", "gf", "<CMD>Lspsaga finder<Cr>", opt)
vim.keymap.set("n", "<leader>j", "<CMD>Lspsaga diagnostic_jump_next<CR>", opt)
