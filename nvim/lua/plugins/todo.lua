return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = 'VeryLazy',
  lazy = true,
  config = function()
    local status, todo = pcall(require, "todo-comments")
    if (not status) then return end
    todo.setup {}
  end
}
