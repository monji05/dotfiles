return {
  cmd = { "lua-language-server" },
  filetype = "lua",
  settings = {
    Lua = {
      diagnostics = {
        unusedLocalExclude = { "_*" },
      },
    },
  },
}
