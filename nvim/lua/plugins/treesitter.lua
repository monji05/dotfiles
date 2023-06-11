return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-context" },
  event = "UIEnter",
  config = function()
    local ts = require("nvim-treesitter.configs")
    require("treesitter-context").setup()

    ts.setup({
      highlight = {
        enable = true,
        disable = { "vim" },
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = {
        enable = true,
        disable = {},
      },
      ensure_installed = {
        "tsx",
        "toml",
        "fish",
        "php",
        "json",
        "yaml",
        "css",
        "html",
        "lua",
        "markdown",
        "markdown_inline",
      },
      autotag = {
        enable = true,
      },
    })

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
  end,
}
