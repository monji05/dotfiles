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
    end,
  },
}
