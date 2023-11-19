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
    end,
  },
}
