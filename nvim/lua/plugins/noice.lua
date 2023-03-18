return {
  "folke/noice.nvim",
  event = 'BufRead',
  module = 'noice',
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    { "MunifTanjim/nui.nvim", event = 'BufEnter' },
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    { "rcarriga/nvim-notify", event = 'BufEnter' },
  },
  config = function()
    local noice = require("noice")

    noice.setup({
      enable = true,
      cmdline = {
        format = {
          cmdline = { pattern = "^:", icon = ":", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " /", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ?", lang = "regex" },
        }
      },
      messages = {
        view_search = "mini",
      },
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
        {
          filter = {
            event = "notify",
            warning = true,
            find = "failed to run generator.*is not executable",
          },
          opts = { skip = true },
        },
      },
    })
    local notify = require('notify')
    notify.setup({
      background_colour = "#000",
      level = 2,
      render = "default"
    })
  end
}
