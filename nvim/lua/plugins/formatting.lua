return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      formatters_by_ft = {
        json = { "jq" },
        php = { "phpcbf" },
      },
      formatters = {
        phpcbf = {
          prepend_args = { "--standard=/Users/erikomishina/www/offerbox/public_html/phpcs_ruleset.xml" },
        },
      },
    },
  },
}
