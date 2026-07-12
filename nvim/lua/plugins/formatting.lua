return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "fixjson", "jq" },
        php = { "phpcbf" },
        javascript = { "biome" }, -- faster 35x than prettier
        typescript = { "biome" },
        go = { "gofumpt" },
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },
}
