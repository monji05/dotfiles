return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "jq" },
        php = { "phpcbf" },
        -- NOTE: AdminFEのときはコメント解除
        -- typescript = { "prettier" },
        -- javascript = { "prettier" },
        -- typescriptreact = { "prettierd" },
        -- javascriptreact = { "prettierd" },
      },
      formatters = {
        phpcbf = {
          prepend_args = { "--standard=/Users/erikomishina/www/offerbox/public_html/phpcs_ruleset.xml" },
        },
      },
      format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback"
      }
    },
  },
}
