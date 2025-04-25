return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim", keys = { "Mason", "MaonsInstall" } },
    opts = {
      formatters_by_ft = {
        json = { "jq" },
      },
    },
  },
}
