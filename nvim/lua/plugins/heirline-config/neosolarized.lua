local heirline = require("heirline.utils")
local get_hl = heirline.get_highlight
local M = {} -- theme

local colors =
{
  base03  = '#002b36',
  base02  = '#073642',
  base01  = '#586e75',
  base00  = '#657b83',
  base0   = '#839496',
  base1   = '#93a1a1',
  base2   = '#eee8d5',
  base3   = '#fdf6e3',
  yellow  = '#b58900',
  orange  = '#cb4b16',
  red     = '#dc322f',
  magenta = '#d33682',
  violet  = '#6c71c4',
  blue    = '#268bd2',
  cyan    = '#2aa198',
  green   = '#859900',
}

local hl = {

  StatusLine = { bg = colors.base03 },

  ReadOnly = { fg = colors.red },

  -- WorkDir = { fg = get_highlight('Comment').fg, bold = true },
  WorkDir = { fg = get_hl('Directory').fg, bold = true },

  CurrentPath = { fg = get_hl('Directory').fg, bold = true },

  FileName = { fg = get_hl('Statusline').fg, bold = true },

  -- GPS = { fg = colors.grey2 },

  DapMessages = { fg = get_hl('Debug').fg },

  Git = {
    branch  = { fg = colors.violet, bold = true },
    added   = { fg = colors.green, bold = true },
    changed = { fg = colors.yellow, bold = true },
    removed = { fg = colors.red, bold = true },
    dirty   = { fg = colors.base1, bold = true },
  },

  LspIndicator = { fg = colors.blue },
  LspServer = { fg = colors.blue, bold = true },

  Diagnostic = {
    error = { fg = get_hl('DiagnosticSignError').fg },
    warn  = { fg = get_hl('DiagnosticSignWarn').fg },
    info  = { fg = get_hl('DiagnosticSignInfo').fg },
    hint  = { fg = get_hl('DiagnosticSignHint').fg }
  },

  ScrollBar = { bg = colors.grey0, fg = colors.fg1 },

  SearchResults = { fg = colors.black, bg = colors.aqua },
}

do
  local mode_colors = {
    normal       = colors.green,
    op           = colors.blue,
    insert       = colors.blue,
    visual       = colors.yellow,
    visual_lines = colors.yellow,
    visual_block = colors.yellow,
    replace      = colors.red,
    v_replace    = colors.red,
    enter        = colors.cyan,
    more         = colors.cyan,
    select       = colors.violet,
    command      = colors.cyan,
    shell        = colors.orange,
    term         = colors.orange,
    none         = colors.red,
  }

  hl.Mode = setmetatable({
    normal = { fg = mode_colors.normal, bg = colors.base03 }
  }, {
    __index = function(_, mode)
      return {
        -- fg = colors.black,
        fg = hl.StatusLine.bg,
        bg = mode_colors[mode],
        bold = true
      }
    end
  })
end

M.lsp_colors = {
  lua_ls = colors.green,
  intelephense = colors.green,
}

M.highlight = hl
M.colors = colors
return M
