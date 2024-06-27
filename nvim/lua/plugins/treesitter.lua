return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css",
        "gitcommit",
        "gitignore",
        "http",
        "norg",
        "norg_meta",
        "php",
        "scss",
        "sql",
      })
      vim.list_extend(opts.textobjects, {
        goto_next_start = { ["]f"] = "@function.outer" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        goto_previous_start = { ["[f"] = "@function.outer" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
      })

      -- laravel blade syntax highlight
      -- https://github.com/EmranMR/tree-sitter-blade/discussions/19
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      vim.cmd([[" Set the *.blade.php file to be filetype of blade
        augroup BladeFiletypeRelated
          au BufNewFile,BufRead *.blade.php set ft=blade
        augroup END
      ]])
    end,
  },
}
