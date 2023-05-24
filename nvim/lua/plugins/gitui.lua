return {
  "aspeddro/gitui.nvim",
  cmd = { "Gitui" },
  config = function()
    require("gitui").setup()
  end,
}
