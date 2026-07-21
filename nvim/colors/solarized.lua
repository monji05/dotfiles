-- ~/.config/nvim/colors/solarized_custom.lua

-- 既存のハイライトをクリア
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "solarized_custom"
vim.o.background = "dark"

-- カラーパレットの定義
local c = {
  base03 = "#002b36",
  -- base03 = "#031219",
  base02 = "#073642",
  base01 = "#586e75",
  base00 = "#657b83",
  base0 = "#839496",
  base1 = "#93a1a1",
  base2 = "#eee8d5",
  base3 = "#fdf6e3",
  yellow = "#b58900",
  orange = "#cb4b16",
  red = "#dc322f",
  magenta = "#d33682",
  violet = "#6c71c4",
  blue = "#268bd2",
  cyan = "#2aa198",
  green = "#859900",
}

-- ハイライトグループの定義
local highlights = {
  -- 基本 UI
  Normal = { fg = c.base0, bg = "NONE" }, -- エディタ全体の背景を透過
  NormalFloat = { fg = c.base0, bg = "NONE" }, -- 浮動ウィンドウの背景を透過
  LineNr = { fg = c.base01, bg = "NONE" }, -- 行番号の背景を透過
  WinSeparator = { fg = c.base02, bg = "NONE" }, -- ウィンドウ分割線の背景を透過
  CursorLine = { bg = c.base02 },
  CursorColumn = { bg = c.base02 },
  ColorColumn = { bg = c.base02 },
  CursorLineNr = { fg = c.base1, bg = c.base02, bold = true },
  VertSplit = { fg = c.base02, bg = c.base02 },
  Visual = { bg = c.base02 },
  Search = { fg = c.yellow, bg = c.base02, reverse = true },
  IncSearch = { fg = c.orange, bg = c.base02, reverse = true },
  MatchParen = { fg = c.base1, bg = c.base02, bold = true }, -- 対応するカッコを強調
  Question = { fg = c.cyan },
  ModeMsg = { fg = c.blue },
  Pmenu = { fg = c.base0, bg = c.base02 },
  PmenuSel = { fg = c.base2, bg = c.base01 },
  PmenuSbar = { bg = c.base02 },
  PmenuThumb = { bg = c.base0 },

  -- 構文ハイライト（基本）
  Comment = { fg = c.base01, italic = true },
  Constant = { fg = c.cyan },
  String = { fg = c.cyan },
  Character = { fg = c.cyan },
  Number = { fg = c.cyan },
  Boolean = { fg = c.cyan },
  Float = { fg = c.cyan },
  Identifier = { fg = c.blue },
  Function = { fg = c.blue },
  Statement = { fg = c.green },
  Conditional = { fg = c.green },
  Repeat = { fg = c.green },
  Label = { fg = c.green },
  Operator = { fg = c.green },
  Keyword = { fg = c.green },
  Exception = { fg = c.green },
  PreProc = { fg = c.orange },
  Include = { fg = c.orange },
  Define = { fg = c.orange },
  Macro = { fg = c.orange },
  PreCondit = { fg = c.orange },
  Type = { fg = c.yellow },
  StorageClass = { fg = c.yellow },
  Structure = { fg = c.yellow },
  Typedef = { fg = c.yellow },
  Special = { fg = c.red },
  SpecialChar = { fg = c.red },
  Tag = { fg = c.red },
  Delimiter = { fg = c.base00 },
  SpecialComment = { fg = c.red },
  Debug = { fg = c.red },
  Underlined = { fg = c.violet, underline = true },
  Ignore = { fg = c.base03 },
  Error = { fg = c.red, bold = true, undercurl = true },
  Todo = { fg = c.magenta, bold = true },

  -- 従来のメッセージ系のカラーリングをOsaka風にシンプルに（reverseなどを外す）
  ErrorMsg = { fg = c.red },
  WarningMsg = { fg = c.yellow },
  MoreMsg = { fg = c.blue },

  -- Lsp Diagnostics (Error, Warning, Info, Hint) の基本テキスト色
  DiagnosticError = { fg = c.red },
  DiagnosticWarn = { fg = c.yellow },
  DiagnosticInfo = { fg = c.blue },
  DiagnosticHint = { fg = c.cyan },

  -- Lsp Diagnostics のアンダーライン（波線・下線など）
  -- `sp` は underline や undercurl の色を指定するプロパティ
  DiagnosticUnderlineError = { undercurl = true, sp = c.red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c.yellow },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c.blue },
  DiagnosticUnderlineHint = { undercurl = true, sp = c.cyan },

  -- Lsp Diagnostics のバーチャルテキスト（行の右端に出るエラーメッセージなど）
  -- 少し背景色をつけて見やすくする（不要なら bg = "NONE" にしてください）
  DiagnosticVirtualTextError = { fg = c.red, bg = c.base02 },
  DiagnosticVirtualTextWarn = { fg = c.yellow, bg = c.base02 },
  DiagnosticVirtualTextInfo = { fg = c.blue, bg = c.base02 },
  DiagnosticVirtualTextHint = { fg = c.cyan, bg = c.base02 },

  -- 診断のサイン（行番号の左に出るアイコンの色）
  DiagnosticSignError = { fg = c.red },
  DiagnosticSignWarn = { fg = c.yellow },
  DiagnosticSignInfo = { fg = c.blue },
  DiagnosticSignHint = { fg = c.cyan },

  -- Neovim 標準の Diff（gitsigns のインラインプレビュー等でも使われます）
  DiffAdd = { bg = c.base02 },
  DiffChange = { bg = c.base02 },
  DiffDelete = { bg = c.base02 },
  DiffText = { bg = c.base01 }, -- 変更行の中で「実際に変更された文字」のハイライト

  -- Gitsigns のサインカラム（行番号の左に表示されるアイコン）
  -- ※ bg = "NONE" にすることで、transparent設定（背景透過）と馴染みます
  GitSignsAdd = { fg = c.green, bg = "NONE" },
  GitSignsChange = { fg = c.yellow, bg = "NONE" },
  GitSignsDelete = { fg = c.orange, bg = "NONE" },

  -- Gitsigns の行ハイライト（行全体に色をつけたい場合に使用されるグループ）
  GitSignsAddLn = { bg = c.base02 },
  GitSignsChangeLn = { bg = c.base02 },
  GitSignsDeleteLn = { bg = c.base02 },

  -- Gitsigns のインライン差分（word diff）
  GitSignsAddInline = { bg = c.base02 },
  GitSignsChangeInline = { bg = c.base02 },
  GitSignsDeleteInline = { bg = c.base02 },

  -- Diffview.nvim のサイドバー (File Panel)
  -- 追加・削除の数字 (+X / -Y)
  DiffviewFilePanelInsertions = { fg = c.green },
  DiffviewFilePanelDeletions = { fg = c.red },
  -- Neovim 標準のディレクトリカラー (Diffviewやファイラー全般で使われます)
  Directory = { fg = c.violet, bold = true },

  -- Tree-sitter 用の設定（より精密な構文解析用）
  ["@comment"] = { link = "Comment" },
  ["@keyword"] = { fg = c.green },
  ["@function"] = { fg = c.blue },
  ["@string"] = { fg = c.cyan },
  ["@number"] = { fg = c.cyan },
  ["@boolean"] = { fg = c.cyan },
  ["@variable"] = { fg = c.base0 },
  ["@variable.builtin.php"] = { fg = c.base0 },
  ["@constant"] = { fg = c.yellow },
  ["@property"] = { fg = c.blue },
  ["@operator"] = { fg = c.green },
  ["@punctuation"] = { fg = c.base00 },
  ["@punctuation.bracket"] = { fg = c.base00 },
  ["@constructor"] = { fg = c.base00 },
  ["@punctuation.special"] = { fg = c.base00 },
  ["@parameter"] = { fg = c.orange },
  ["@variable.phpdoc"] = { fg = c.orange },
  ["@variable.parameter.phpdoc"] = { fg = c.orange },

  -- LSP (intelephense や phpactor など) を使っている場合のセマンティックトークン対応
  ["@lsp.type.class"] = { fg = c.orange },
  ["@lsp.type.type"] = { fg = c.orange },

  ["@constructor.php"] = { fg = c.orange },
}

-- ハイライトの適用
for group, opts in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end
vim.api.nvim_command([[highlight Hlargs guifg=#cb4b16]])
