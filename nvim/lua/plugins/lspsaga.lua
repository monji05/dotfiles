return {
  "kkharji/lspsaga.nvim", -- LSP UIs
  event = "BufRead",
  opts = {
    debug = false,
    use_saga_diagnostic_sign = true,
    -- diagnostic sign
    error_sign = "",
    warn_sign = "",
    hint_sign = "",
    infor_sign = "",
    diagnostic_header_icon = "   ",
    -- code action title icon
    code_action_icon = " ",
    code_action_prompt = {
      enable = true,
      sign = true,
      sign_priority = 40,
      virtual_text = true,
    },
    finder_definition_icon = "  ",
    finder_reference_icon = "  ",
    max_preview_lines = 10,
    finder_action_keys = {
      open = "o",
      vsplit = "s",
      split = "i",
      quit = "q",
      scroll_down = "<C-f>",
      scroll_up = "<C-b>",
    },
    code_action_keys = {
      quit = "q",
      exec = "<CR>",
    },
    rename_action_keys = {
      quit = "<C-c>",
      exec = "<CR>",
    },
    definition_preview_icon = "  ",
    border_style = "single",
    rename_prompt_prefix = "➤",
    rename_output_qflist = {
      enable = true,
      auto_open_qflist = true,
    },
    server_filetype_map = {},
    diagnostic_prefix_format = "%d. ",
    diagnostic_message_format = "%m %c",
    highlight_prefix = false,
  },
  keys = {
    { "gd", "<CMD>Lspsaga lsp_finder<CR>" },
    { "gh", "<CMD>Lspsaga hover_doc<CR>" },
    -- use increname
    -- { "gr", "<CMD>Lspsaga rename<CR>" },
    { "<leader>j", "<CMD>Lspsaga diagnostic_jump_next<CR>" },
    -- use zellij
    -- { "<C-t>",     "<CMD>Lspsaga toggle_floaterm<CR>" },
    -- { "<C-t>",     mode = "t",                             "<CMD>Lspsaga close_floaterm<CR>" },
  },
}
