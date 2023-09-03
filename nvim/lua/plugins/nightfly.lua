local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
local highlight = vim.api.nvim_set_hl
local diff_add = "#023259"
local diff_change = "#1d3b53"
local diff_delete = "#4C1A22"
local diff_text = "#7c8f8f"
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "nightfly",
  callback = function()
    -- Git diff
    highlight(0, "DiffAdd", { fg = "none", bg = diff_add })
    highlight(0, "DiffChange", { fg = "none", bg = diff_change })
    highlight(0, "DiffText", { fg = "none", bg = diff_text })
    highlight(0, "DiffDelete", { fg = "none", bg = diff_delete })
    highlight(0, "MiniIndentScopeSymbol", { fg = "#ff5874" })
    -- syntax
  end,
  group = custom_highlight,
})
vim.api.nvim_command("colorscheme nightfly")
