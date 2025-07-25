return {
  {
    "ibhagwan/fzf-lua",
    lazy = true,
  },
  {
    "otavioschwanck/fzf-lua-explorer.nvim",
    keys = {
      { "<leader>f", "<cmd>lua require('fzf-lua-explorer').explorer()<cr>", desc = "Explorer" },
    },
    opts = {
      keybindings = {
        create_file = "ctrl-a",
        rename_file = "ctrl-r",
        cut_files = "ctrl-x",
        copy_files = "ctrl-y",
        paste_files = "ctrl-v",
        clean_clipboard = "ctrl-e",
        go_to_cwd = "ctrl-g",
        go_to_parent = "ctrl-b",
        find_folders = "ctrl-f",
        delete_files = "ctrl-d",
        open_vsplit = "ctrl-s",
        open_hsplit = "ctrl-h",
      },
    },
  },
}
