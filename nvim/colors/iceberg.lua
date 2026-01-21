-- colors/iceberg_lua.lua

-- 1. 初期化: 既存のハイライトをリセット
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "iceberg_lua"

-- 2. カラーパレットの定義 (Icebergオリジナルの色)
local colors = {
  bg = "#161821",
  fg = "#d2d4de",
  black = "#161821",
  red = "#e27878",
  green = "#b4be82",
  yellow = "#e2a478",
  blue = "#84a0c6",
  magenta = "#a093c7",
  cyan = "#89b8c2",
  white = "#c6c8d1",
  -- 明るい色や特殊な色
  gray = "#6b7089",
  l_gray = "#444b71",
  selection = "#1e2132",
}

-- 3. ハイライト設定関数
local function set_hl(group, options)
  vim.api.nvim_set_hl(0, group, options)
end

-- 4. 標準ハイライトグループの定義
-- 背景と前景
set_hl("Normal", { fg = colors.fg, bg = colors.bg })
set_hl("NonText", { fg = colors.l_gray })

-- 基本のシンタックス
set_hl("Comment", { fg = colors.gray, italic = true })
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

-- Types & Tags (型・タグ)
set_hl("@type", { fg = colors.green })
set_hl("@type.builtin", { fg = colors.blue })
set_hl("@tag", { fg = colors.blue })
set_hl("@tag.attribute", { fg = colors.cyan })
set_hl("@tag.delimiter", { fg = colors.gray })
