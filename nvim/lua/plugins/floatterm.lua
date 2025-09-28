return {
  {
    -- This are the mappings for sidebar
    --     a -> add new terminal
    --     e -> edit terminal name
    --     Pressing any number within sidebar will switch to that terminal
    --
    -- Must be pressed in main terminal buffer
    --     Ctrl + h -> Switch to sidebar
    --     Ctrl + j -> Cycle to prev terminal
    --     Ctrl + k -> Cycle to next terminal
    "nvzone/floaterm",
    keys = {
      {
        ";t",
        ":FloatermToggle<CR>",
        "toggle floaterm",
      },
    },
    opts = {
      border = true,
      size = { h = 85, w = 90 },

      -- to use, make this func(buf)
      mappings = { sidebar = nil, term = nil },

      -- Default sets of terminals you'd like to open
      terminals = {
        { name = "lazygit", cmd = "lazygit" },
        -- cmd can be function too
      },
    },
  },
  {
    "nvzone/volt",
    lazy = true,
  },
}
