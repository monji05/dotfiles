-- ~/.config/nvim/lua/plugins/float-todo.lua
return {
  {
    dir = vim.fn.stdpath("config"),
    main = "my-plugins.float-todo",
    opts = {},
    keys = {
      {
        "<leader>tt",
        "<CMD>:TodoFloatOpen<CR>",
      },
    },
  },
}
