require("lualine").setup({
options = {
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
    { require("NeoComposer.ui").status_recording },
  },
  lualine_z = {
    "os.date(' %m-%d(%a) %H:%M')",
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
