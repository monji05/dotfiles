return {
  "aserowy/tmux.nvim",
  config = function()
    require("tmux").setup()
  end,
  keys = {
    {
      "<C-h>",
      function()
        require("tmux").move_left()
      end,
    },
    {
      "<C-j>",
      function()
        require("tmux").move_bottom()
      end,
    },
    {
      "<C-k>",
      function()
        require("tmux").move_right()
      end,
    },
    {
      "<C-l>",
      function()
        require("tmux").move_right()
      end,
    },
  },
}
