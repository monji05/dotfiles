return {
  {
    "nvim-lualine/lualine.nvim", -- Statusline
    event = { "InsertEnter", "CursorHold", "FocusLost", "BufRead", "BufNewFile" },
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      module = { "nvim-web-devicons" },
    },
    config = function()
      local my_nightfly = require("lualine.themes.nightfly")
      local my_b_bg = "#414455"
      my_nightfly.normal.b.bg = my_b_bg
      my_nightfly.insert.b.bg = my_b_bg
      my_nightfly.visual.b.bg = my_b_bg
      my_nightfly.replace.b.bg = my_b_bg
      my_nightfly.inactive.b.bg = my_b_bg

      require("lualine").setup({
        options = {
          -- theme = my_nightfly,
          theme = "solarized_dark",
          icons_enabled = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "filename",
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1,           -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
            "diff",
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
          },
          lualine_z = {
            "os.date(' %H:%M')",
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
}
