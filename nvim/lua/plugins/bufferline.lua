return {
  "akinsho/nvim-bufferline.lua",
  event = "TabEnter",
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>" },
    { "<leader>p", "<Cmd>BufferLinePick<CR>" },
  },
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant",
      always_show_bufferline = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      color_icons = true,
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        style = "icon",
      },
      diagnostics = "nvim_lsp",
      hover = {
        enabled = false,
      },
    },
    highlights = {
      separator = {
        fg = "#073642",
        bg = "#002b36",
      },
      separator_selected = {
        fg = "#073642",
      },
      background = {
        fg = "#657b83",
        bg = "#002b36",
      },
      buffer_selected = {
        fg = "#fdf6e3",
        bold = true,
      },
      fill = {
        bg = "#073642",
      },
    },
  },
}
