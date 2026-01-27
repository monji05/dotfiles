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

-- 9. snacks.nvim (Picker / Explorer)

-- パス（ディレクトリ）を控えめなグレーにして、ファイル名を目立たせる
set_hl("SnacksPickerDir", { fg = colors.gray })
set_hl("SnacksPickerPath", { fg = colors.gray })
set_hl("SnacksPickerFileName", { fg = colors.fg })

-- 入力した文字と一致する部分（マッチング）
set_hl("SnacksPickerMatch", { fg = colors.yellow, bold = true })

-- 枠線とプロンプト
set_hl("SnacksPickerBorder", { fg = colors.blue })
set_hl("SnacksPickerPrompt", { fg = colors.blue, bold = true })

-- 選択されている行（カーソル位置）
set_hl("SnacksPickerSelected", { bg = colors.selection, fg = colors.cyan })

-- ダッシュボード（snacks.dashboard）を使う場合
set_hl("SnacksDashboardHeader", { fg = colors.blue })
set_hl("SnacksDashboardFooter", { fg = colors.gray })
set_hl("SnacksDashboardDesc", { fg = colors.cyan })
set_hl("SnacksDashboardKey", { fg = colors.magenta })

local function set_transparent()
  -- 背景を透明にする（bg = "NONE" または nil）
  local transparent_groups = {
    "Normal",
    "NormalFloat",
    "NormalNC", -- 非アクティブなウィンドウ
    "Folded",
    "NonText",
    "SpecialKey",
    "SignColumn",
    "EndOfBuffer",
  }

  for _, group in ipairs(transparent_groups) do
    set_hl(group, { fg = nil, bg = "NONE" }) -- bgをNONEに設定
  end

  -- snacks.nvim の背景も透明に合わせる場合
  set_hl("SnacksPicker", { bg = "NONE" })
  set_hl("SnacksNormal", { bg = "NONE" })
end

-- 透過設定を有効にする
set_transparent()

-- 11. コメントの視認性調整 (透過用)
-- 元の gray (#6b7089) よりも少し明るい色を定義
local bright_comment = "#7a819d"

-- コメントのハイライトを上書き
set_hl("Comment", { fg = bright_comment, italic = true })

-- ついでに PHPDoc の説明文も同じ色にして読みやすくする
set_hl("@text.phpdoc", { fg = bright_comment })

-- Tree-sitterのconfig nvim/after/queries/php/highlights.scmで新しく定義した @variable.sigil($) に色を付ける
set_hl("@variable.sigil", { fg = colors.blue })

-- PHPDoc 内の変数名を、hlargs.nvimで設定しているハイライトと同じ色に設定
set_hl("@variable.parameter.phpdoc", { fg = colors.magenta })

-- Undercurl（波線の下線）の設定
set_hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
set_hl("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.yellow })
set_hl("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.blue })
set_hl("DiagnosticUnderlineHint", { undercurl = true, sp = colors.cyan })
