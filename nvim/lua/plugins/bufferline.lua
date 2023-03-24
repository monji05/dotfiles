return {
  "akinsho/nvim-bufferline.lua",
  event = "TabEnter",
  keys = {
    { "<Tab>",     "<Cmd>BufferLineCycleNext<CR>" },
    { "<S-Tab>",   "<Cmd>BufferLineCyclePrev<CR>" },
    { "<leader>p", "<Cmd>BufferLinePick<CR>" },
  },
  opts = {
    options = {
      mode = "tabs",
      separator_style = "padded",
      always_show_bufferline = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      color_icons = true,
    },
    highlights = {},
  },
}
