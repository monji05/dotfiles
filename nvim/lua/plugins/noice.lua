return {
  "folke/noice.nvim",
  event = "BufEnter",
  module = "noice",
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  opts = {
    -- add any options here
    cmdline = {
      format = {
        cmdline = { pattern = "^:", icon = ":", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = ":help" },
      },
    },
    messages = {
      view = "mini",
      view_warn = "mini",
      view_error = "mini",
      view_search = "mini",
    },
    notify = {
      view = "mini",
    },
    lsp = {
      override = {
        -- override the default lsp markdown formatter with Noice
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        -- override the lsp markdown formatter with Noice
        ["vim.lsp.util.stylize_markdown"] = true,
        -- override cmp documentation with Noice (needs the other options to work)
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      inc_rename = true,
    },
  },
  keys = {
    { "<leader>H", "<CMD>NoiceHistory<CR>" },
  },
}
