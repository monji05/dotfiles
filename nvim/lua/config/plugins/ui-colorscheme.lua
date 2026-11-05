require("solarized-osaka").setup({
  style = "vivid",
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
    floats = "transparent",
    sidebars = "transparent",
  },

  ---@param colors ColorScheme
  on_colors = function(colors)
    -- colors.base0 = "#92a0a0"
  end,

  ---@param hl Highlights
  ---@param c ColorScheme
  on_highlights = function(hl, c)
    hl.LineNr = { fg = c.base01 }
    hl.CursorLineNr = { fg = c.green500, bg = c.green900 }

    -- gitsigns word_diff
    hl.GitSignsAddLnInline = { bg = c.green700 }
    hl.GitSignsAddLn = { bg = c.green700 }
    hl.GitSignsUntrackedLn = { bg = c.magenta }
    hl.GitSignsChangeLn = { bg = c.yellow900 }
    hl.GitSignsChangeLnInline = { bg = c.yellow700 }
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
