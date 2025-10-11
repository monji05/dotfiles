return {
  {
    "nvim-mini/mini.icons",
    lazy = true,
  },
  {
    "A7Lavinraj/fyler.nvim",
    branch = "stable",
    keys = {
      {
        "<leader>f",
        ":Fyler<CR>",
      },
    },
    opts = {
      indentscope = {
        enabled = true,
        group = "FylerIndentMarker",
        marker = "▏",
      },

      git_status = {
        enabled = true,
        symbols = {
          Modified = "●",
          Added = "✚",
          Deleted = "✖",
          Untracked = "?",
        },
      },

      mappings = {
        ["<C-c>"] = "CloseView",
        ["<Tab>"] = "Select",
        ["v"] = "SelectVSplit",
        ["s"] = "SelectSplit",
        ["<BS>"] = "GotoParent",
      },

      win = {
        border = "single",
        kind = "float",
        kind_presets = {
          my_layout = {
            width = "1rel",
          },
        },
      },
    },
  },
}
