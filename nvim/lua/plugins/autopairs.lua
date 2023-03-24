return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local status, ts = pcall(require, "nvim-autopairs")
    if (not status) then return end

    ts.setup {
      highlight = {
        enable = true,
        disable = {},
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
        "lua"
      },
      autotag = {
        enable = true,
      },
    }

    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
  end
}