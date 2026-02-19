-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- --- 環境設定 ---
-- OS判定: Unix系なら英語(UTF-8)を強制。エラーメッセージの文字化け防止などに役立ちます。
if vim.fn.has("unix") == 1 then
  vim.env.LANG = "en_US.UTF-8"
else
  vim.env.LANG = "en"
end

-- 内部エンコーディングをUTF-8に設定
vim.o.encoding = "utf-8"

-- --- キーマッピングの基本 ---
-- Leaderキー（プレフィックスキー）をスペースキーに設定（LazyVimの推奨設定）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- --- 行番号と表示 ---
vim.opt.relativenumber = true -- 相対行番号を表示（現在行からの距離がわかる）
vim.opt.signcolumn = "yes" -- 左端のサイン列（Gitの状態やエラー表示用）を常に表示し、ガタつきを防ぐ
vim.opt.number = true -- 現在行の行番号を表示

vim.opt.title = true -- ターミナルのタイトルをNeovimで編集中のファイル名に変更

-- --- インデント（字下げ）設定 ---
vim.opt.autoindent = true -- 改行時に前の行のインデントを継続
vim.opt.smartindent = true -- C言語のような構文に合わせてインデントを自動調整
vim.opt.tabstop = 2 -- タブ文字をスペース2つ分として表示
vim.opt.shiftwidth = 2 -- 自動インデントの幅をスペース2つ分に設定
vim.opt.expandtab = true -- タブ入力をスペースに変換（スペース派の設定）
vim.opt.smarttab = true -- 行頭のタブ入力をshiftwidthに合わせて調整

-- --- 検索・コマンドライン ---
vim.opt.hlsearch = true -- 検索マッチ箇所をハイライト
vim.opt.backup = false -- バックアップファイル（~付き）を作成しない
vim.opt.showcmd = true -- 入力中のコマンドを右下に表示
vim.opt.cmdheight = 1 -- コマンドラインの高さを1行確保
vim.opt.inccommand = "split" -- 置換コマンド入力中に、プレビュー画面を分割してリアルタイム表示
vim.opt.ignorecase = true -- 検索時に大文字・小文字を区別しない
-- ※スマートケース（大文字が含まれる場合のみ区別）の設定を入れる場合: vim.opt.smartcase = true

-- --- スクロール・ナビゲーション ---
vim.opt.scrolloff = 30 -- ★特徴的: カーソルの上下に常に30行の余白を保つ（常に画面中央で編集するスタイル）
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" } -- 特定のパスではバックアップを作らない
vim.opt.breakindent = true -- 折り返された行もインデントを維持して見やすくする
vim.opt.wrap = false -- 長い行を折り返さない（画面外へ突き抜ける）
vim.opt.backspace = { "start", "eol", "indent" } -- Backspaceキーで何でも消せるようにする
vim.opt.path:append({ "**" }) -- `:find` コマンドなどでサブディレクトリまで再帰的に検索
vim.opt.iskeyword:append("-") -- ハイフン付きの単語（kebab-case）を1つの単語として扱う

-- --- システム・ウィンドウ ---
vim.opt.laststatus = 0 -- ★ステータスライン（下のバー）を非表示にする（通常は2か3）
vim.opt.shada = "" -- ★Shada（履歴やマークなどの保存）を無効化（再起動で履歴が消える設定）
vim.opt.swapfile = false -- スワップファイル（.swp）を作成しない
vim.opt.shell = "fish" -- Neovim内で使うシェルを `fish` に指定
vim.opt.splitbelow = true -- 横分割時、新しいウィンドウを下に開く
vim.opt.splitright = true -- 縦分割時、新しいウィンドウを右に開く
vim.opt.wildignore:append({ "*/node_modules/*" }) -- ファイル検索などで `node_modules` を無視
vim.opt.splitkeep = "cursor" -- 分割時にカーソル位置がずれないように画面スクロールを維持
vim.opt.mouse = "" -- ★マウス操作を無効化（LazyVimデフォルトは有効）

-- --- 見た目・ハイライト ---
vim.opt.background = "dark" -- 背景色をダークモード向けに設定

-- UI記号のカスタマイズ（折りたたみ、Diffの表示など）
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ", -- バッファの終わり（チルダ ~）を空白にして隠す
}

-- --- 自動コマンド ---
-- インサートモードを抜けた時にペーストモードを解除（誤爆防止）
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- --- その他 ---
-- ブロックコメント内でEnterを押した時、自動でアスタリスクなどを挿入する
vim.opt.formatoptions:append({ "r" })

-- Markdownプレビュープラグインのテーマ設定（Solarized Osaka）
vim.api.nvim_command([[let g:nvim_markdown_preview_theme = 'solarized-osaka']])

-- Git Blameプラグインを無効化（行ごとのGit情報を出さない）
vim.g.gitblame_enabled = 0

-- アンダーカール（波線の下線）を有効にするためのターミナルエスケープシーケンス設定
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
-- "maxmx03/solarized.nvim"を使用するときは以下をコメントしないとタイポと判定されるコメントがすべて横線が入る
-- vim.cmd([[let &t_Cs = "\e[60m"]])
-- vim.cmd([[let &t_Ce = "\e[24m"]])
-- vim.cmd([[hi SpellBad   guisp=red    gui=undercurl term=underline cterm=undercurl]])
-- vim.cmd([[hi SpellCap   guisp=yellow gui=undercurl term=underline cterm=undercurl]])
-- vim.cmd([[hi SpellRare  guisp=blue   gui=undercurl term=underline cterm=undercurl]])
-- vim.cmd([[hi SpellLocal guisp=orange gui=undercurl term=underline cterm=undercurl]])
-- vim.cmd([[set spell]])

-- 重複設定（上ですでに設定されているため削除しても良い）
-- vim.opt.formatoptions:append({ "r" })
