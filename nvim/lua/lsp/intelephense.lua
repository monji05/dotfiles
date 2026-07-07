vim.lsp.config('intelephense', {
  -- Mason等でパスが通っていればコマンド名のみでOK
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },

  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name

      -- 例: プロジェクト直下に wp-config.php がある場合、WordPress用のスタブを動的に追加する
      if vim.uv.fs_stat(path .. '/wp-config.php') then
        client.config.settings.intelephense = vim.tbl_deep_extend('force', client.config.settings.intelephense or {}, {
          stubs = {
            "wordpress",
            -- 基本的なPHPスタブ（Intelephenseがデフォルトで持つものを上書きする場合は列挙が必要なことがあります）
            "Core", "date", "PDO", "standard", "Reflection", "SPL", "json", "mbstring"
          }
        })
      end

      -- 例: 特定のプロジェクトでPHPのバージョンを動的に切り替える
      -- if vim.uv.fs_stat(path .. '/.php-version') then
      --   -- ファイルからバージョンを読み取って設定する処理などをここに書く
      -- end
    end
  end,

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
