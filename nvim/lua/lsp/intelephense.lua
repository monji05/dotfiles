vim.lsp.config("intelephense", {
  -- Mason等でパスが通っていればコマンド名のみでOK
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_markers = { "composer.json", ".git" },

  settings = {
    intelephense = {
      -- プロジェクト全体で適用される基本設定
      files = {
        maxSize = 5000000, -- 5MB: 大きすぎるファイルを無視して軽くする
      },
      environment = {
        -- phpVersion = "8.2", -- 必要であればデフォルトのPHPバージョンを指定
      },
      format = {
        enable = true, -- Intelephenseのフォーマッターを有効にするか
      },
    },
  },
})
