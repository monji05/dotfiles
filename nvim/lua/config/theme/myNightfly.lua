-- override nightfly highlight
local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
local highlight = vim.api.nvim_set_hl
local my_emerald = "#0D4F43"
local my_slate_blue = "#2c3043"
local my_red = "#fc514e"
local my_black = "#161821"
local my_change = "#394A58"
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "nightfly",
  callback = function()
    -- gitDiff preview
    highlight(0, "DiffAdd", { fg = "none", bg = my_emerald })
    highlight(0, "DiffChange", { fg = "none", bg = my_slate_blue })
    highlight(0, "DiffDelete", { fg = my_red, bg = my_black })
    highlight(0, "DiffText", { fg = "none", bg = my_change })
    -- mini.indentscope current scope line highlight
    highlight(0, "MiniIndentScopeSymbol", { fg = my_red })
  end,
  group = custom_highlight,
})
vim.api.nvim_command([[colorscheme nightfly]])
vim.g.nightflyTransparent = true



local hoge = 'hoge'
local foo = {
  hoge,
  "foo",
  {
    "b",
    "c"
  },
  "aaaa",
}
