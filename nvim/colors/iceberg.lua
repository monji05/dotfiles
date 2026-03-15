-- ~/.config/nvim/colors/iceberg.lua

-- パレットのエクスポート（読み込み）
local palette = require("iceberg_palette")
local colors = palette.colors

-- 初期化
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "iceberg"

-- ハイライト設定関数
local function set_hl(group, options)
  vim.api.nvim_set_hl(0, group, options)
end

-- 標準ハイライトグループの定義
set_hl("Normal", { fg = colors.fg, bg = colors.bg })
set_hl("NonText", { fg = colors.l_gray })

-- 基本のシンタックス
set_hl("Comment", { fg = colors.bright_comment, italic = true })
set_hl("Constant", { fg = colors.magenta })
set_hl("String", { fg = colors.cyan })
set_hl("Identifier", { fg = colors.cyan })
set_hl("Function", { fg = colors.cyan })
set_hl("Statement", { fg = colors.blue, bold = false })
set_hl("PreProc", { fg = colors.blue })
set_hl("Type", { fg = colors.blue, bold = false })
set_hl("Special", { fg = colors.green })
set_hl("Underlined", { underline = true })
set_hl("Error", { fg = colors.red, bg = colors.bg })
set_hl("Todo", { fg = colors.yellow, bg = colors.bg, bold = true })

-- UI要素
set_hl("CursorLine", { bg = colors.selection })
set_hl("Visual", { bg = colors.selection })
set_hl("LineNr", { fg = colors.l_gray })
set_hl("CursorLineNr", { fg = colors.fg, bg = colors.selection })
set_hl("Pmenu", { fg = colors.fg, bg = colors.selection })
set_hl("PmenuSel", { fg = colors.bg, bg = colors.blue })

-- Tree-sitter 関連
set_hl("@type", { fg = colors.green })
set_hl("@type.builtin", { fg = colors.blue })
set_hl("@tag", { fg = colors.blue })
set_hl("@tag.attribute", { fg = colors.cyan })
set_hl("@tag.delimiter", { fg = colors.gray })
set_hl("@variable.sigil", { fg = colors.blue })
set_hl("@variable.parameter.phpdoc", { fg = colors.magenta })
set_hl("@text.phpdoc", { fg = colors.bright_comment })

-- snacks.nvim (Picker / Dashboard)
set_hl("SnacksPickerDir", { fg = colors.gray })
set_hl("SnacksPickerPath", { fg = colors.gray })
set_hl("SnacksPickerFileName", { fg = colors.fg })
set_hl("SnacksPickerMatch", { fg = colors.yellow, bold = true })
set_hl("SnacksPickerBorder", { fg = colors.blue })
set_hl("SnacksPickerPrompt", { fg = colors.blue, bold = true })
set_hl("SnacksPickerSelected", { bg = colors.selection, fg = colors.cyan })
set_hl("SnacksDashboardHeader", { fg = colors.blue })
set_hl("SnacksDashboardFooter", { fg = colors.gray })
set_hl("SnacksDashboardDesc", { fg = colors.cyan })
set_hl("SnacksDashboardKey", { fg = colors.magenta })

-- 透過設定
local function set_transparent()
  local transparent_groups = {
    "Normal",
    "NormalFloat",
    "NormalNC",
    "Folded",
    "NonText",
    "SpecialKey",
    "SignColumn",
    "EndOfBuffer",
  }
  for _, group in ipairs(transparent_groups) do
    set_hl(group, { fg = nil, bg = "NONE" })
  end
  set_hl("SnacksPicker", { bg = "NONE" })
  set_hl("SnacksNormal", { bg = "NONE" })
end

set_transparent()

-- 特殊ハイライト (Undercurl)
set_hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
set_hl("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.yellow })
set_hl("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.blue })
set_hl("DiagnosticUnderlineHint", { undercurl = true, sp = colors.cyan })

-- Diff / Incline 用
set_hl("DiffAdd", { fg = colors.green })
set_hl("DiffChange", { fg = colors.yellow })
set_hl("DiffAdded", { fg = colors.green })
set_hl("DiffChanged", { fg = colors.yellow })
set_hl("DiffRemoved", { fg = colors.red })
set_hl("DiffDelete", { fg = colors.red })
set_hl("DiffText", { fg = colors.bg, bg = colors.blue })

-- GitSigns
set_hl("GitSignsAdd", { fg = colors.green, bg = "NONE" })
set_hl("GitSignsChange", { fg = colors.yellow, bg = "NONE" })
set_hl("GitSignsDelete", { fg = colors.red, bg = "NONE" })

-- Snacks Git
set_hl("SnacksPickerGitStatusAdded", { fg = colors.green })
set_hl("SnacksPickerGitStatusModified", { fg = colors.yellow })
set_hl("SnacksPickerGitStatusDeleted", { fg = colors.red })
set_hl("DiffDelete", { fg = colors.red })
set_hl("DiffText", { fg = colors.bg, bg = colors.blue }) -- 視認性のため背景追加

-- GitSigns
set_hl("GitSignsAdd", { fg = colors.green, bg = "NONE" })
set_hl("GitSignsChange", { fg = colors.yellow, bg = "NONE" })
set_hl("GitSignsDelete", { fg = colors.red, bg = "NONE" })

-- Snacks Git
set_hl("SnacksPickerGitStatusAdded", { fg = colors.green })
set_hl("SnacksPickerGitStatusModified", { fg = colors.yellow })
set_hl("SnacksPickerGitStatusDeleted", { fg = colors.red })
