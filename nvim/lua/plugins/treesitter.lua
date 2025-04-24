return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "css",
        "gitcommit",
        "gitignore",
        "http",
        "php",
        "scss",
        "sql",
      },
    },
    textobjects = {
      goto_next_start = { ["]f"] = "@function.outer" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
      goto_previous_start = { ["[f"] = "@function.outer" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
}
