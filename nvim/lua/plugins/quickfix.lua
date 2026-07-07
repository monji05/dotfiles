return {
  {
    -- edit quickfix e.g. dd is enable deleting selected one in quickfix list
    "stevearc/quicker.nvim",
    ft = "qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      auto_enable = true,
      func_map = {
        vsplit = "",
      },
    },
  },
}
