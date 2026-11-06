require("solarized-osaka").setup({
  style = "vivid",
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
    floats = "transparent",
    sidebars = "transparent",
  },

  ---@param hl Highlights
  ---@param c ColorScheme
  on_highlights = function(hl, c)
    hl.LineNr = { fg = c.base01 }
  end,
})

vim.cmd.colorscheme("solarized-osaka")

-- hlargs
-- Must run after the colorscheme: it copies the colour of the parameter group.
require("hlargs").setup({})

-- candidate highlight groups for function parameters (priority order)
local param_groups = {
  "@variable.parameter", -- Treesitter (Neovim 0.9+)
  "@lsp.type.parameter", -- LSP semantic tokens
  "@parameter", -- legacy Treesitter
  "Identifier", -- Vim fallback
}

local fg_color
for _, group_name in ipairs(param_groups) do
  local hl = vim.api.nvim_get_hl(0, { name = group_name, link = false })
  if hl and hl.fg then
    fg_color = hl.fg
    break
  end
end

if fg_color then
  vim.api.nvim_set_hl(0, "Hlargs", { fg = string.format("#%06x", fg_color) })
end
