return {
  "petertriho/nvim-scrollbar",
  event = {
    "BufWinEnter",
    "CmdwinLeave",
    "TabEnter",
    "TermEnter",
    "TextChanged",
    "VimResized",
    "WinEnter",
    "WinScrolled",
  },
  opts = {
    -- marks = {
    --   GitAdd = {
    --     text = "+",
    --     priority = 7,
    --     gui = nil,
    --     color = nil,
    --     cterm = nil,
    --     color_nr = nil, -- cterm
    --     highlight = "GitSignsAddNr",
    --   },
    --   GitChange = {
    --     text = "|",
    --     priority = 7,
    --     gui = nil,
    --     color = nil,
    --     cterm = nil,
    --     color_nr = nil, -- cterm
    --     highlight = "GitSignsChangeNr",
    --   },
    --   GitDelete = {
    --     text = "▁",
    --     priority = 7,
    --     gui = nil,
    --     color = nil,
    --     cterm = nil,
    --     color_nr = nil, -- cterm
    --     highlight = "GitSignsDeleteNr",
    --   },
    -- },
  },
}
