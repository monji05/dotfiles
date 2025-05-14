return {
  {
    "stevearc/conform.nvim",
    { "mason.nvim", lazy = true, keys = {
      "Mason",
      "MaonsInstall",
    } },
    opts = {
      formatters_by_ft = {
        json = { "jq" },
      },
    },
  },
}
