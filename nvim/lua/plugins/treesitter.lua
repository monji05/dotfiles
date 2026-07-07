return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy=false,
    branch = "main",
    config = function ()
      require('nvim-treesitter').setup({
        ensure_installed = {
          "vim",
          "php",
          "diff",
          "lua",
          "json",
          "go",
          "javascript"
        }
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
}
