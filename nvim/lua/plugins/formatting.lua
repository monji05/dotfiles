return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim", keys = { "Mason", "MaonsInstall" } },
    opts = {
      formatters_by_ft = {
        json = { "jq" },
        php = { "phpcbf" },
        typescript = { "prettier" },
        javascript = { "prettier" },
        typescriptreact = { "prettierd" },
        javascriptreact = { "prettierd" },
      },
      formatters = {
        phpcbf = {
          prepend_args = { "--standard=/Users/erikomishina/www/offerbox/public_html/phpcs_ruleset.xml" },
        },
      },
    },
  },
}
