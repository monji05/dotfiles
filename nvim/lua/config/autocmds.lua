-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Fix conceallevel for json file
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

-- task manager
vim.api.nvim_create_user_command("ConvertTask", function()
  -- 現在の行を取得
  local line = vim.api.nvim_get_current_line()

  -- タスクのタイトルを抽出
  local task_title = line:match("%- %[[ x]%] (.+)")
  if not task_title then
    print("No valid task found on the current line.")
    return
  end

  -- ファイル名をインタラクティブに取得
  local file_name = vim.fn.input("What is your file name: ")
  if file_name == "" then
    print("File name cannot be empty.")
    return
  end

  -- ディレクトリが存在しない場合は作成
  local dir_path = "./tasks/"
  vim.fn.mkdir(dir_path, "p")

  -- 新しいファイルを作成
  local file_path = dir_path .. file_name .. ".md"
  local file = io.open(file_path, "w")
  if file then
    file:write("# " .. task_title .. "\n\n")
    file:write("## Reference\n\n")
    file:write("## Artifact\n\n")
    file:close()
    print("File created: " .. file_path)
  else
    print("Failed to create file: " .. file_path)
    return
  end

  -- 現在の行をリンク付きの形式に更新
  local new_line = line:gsub(task_title, "[" .. task_title .. "](" .. file_path .. ")")
  vim.api.nvim_set_current_line(new_line)
end, {})

-- Neovim Lua APIを使用して新しいコマンドを定義
vim.api.nvim_create_user_command("OpenTask", function()
  -- 現在の行を取得
  local line = vim.api.nvim_get_current_line()

  -- リンクのファイルパスを抽出
  local file_path = line:match("%((.-)%)")
  if file_path then
    -- ファイルを開く
    vim.cmd("edit " .. file_path)
  else
    print("No valid link found on the current line.")
  end
end, {})

-- ArchiveTaskコマンドを定義
vim.api.nvim_create_user_command("ArchiveTask", function()
  -- 現在の行を取得
  local line = vim.api.nvim_get_current_line()
  local current_line_num = vim.api.nvim_win_get_cursor(0)[1]

  -- 今日の日付を取得 (YYYYMMDD形式)
  local date = os.date("%Y%m%d")
  local archive_dir = "./archives/" .. date

  -- ディレクトリが存在しない場合は作成
  vim.fn.mkdir(archive_dir, "p")

  -- リンクのファイルパスを抽出
  local file_path = line:match("%((.-)%)")

  if file_path then
    -- リンク付きタスクの場合
    -- ファイル名を抽出
    local file_name = file_path:match("([^/]+)$")
    if not file_name then
      print("Failed to extract file name from path.")
      return
    end

    -- 新しいファイルパスを作成
    local new_file_path = archive_dir .. "/" .. file_name

    -- ファイルを移動
    local success = os.rename(file_path, new_file_path)
    if success then
      print("File moved to: " .. new_file_path)

      -- 現在の行のリンクを新しいパスに更新して完了状態にする
      local new_line = line:gsub("%((.-)%)", "(" .. new_file_path .. ")")
      new_line = new_line:gsub("%- %[ ?%]", "- [x]")

      -- 行を更新（リンク付きタスクの場合は行を残す）
      vim.api.nvim_set_current_line(new_line)
      print("Task archived and link updated")
    else
      print("Failed to move file.")
    end
  else
    -- リンクなしタスクの場合（新しい処理）
    -- タスクのテキストを抽出（3つのパターンに対応）
    local task_text = line:match("%- %[x%] (.+)") or line:match("%- %[ %] (.+)") or line:match("%- %[%] (.+)")
    if not task_text then
      print("No valid task found on the current line.")
      return
    end

    -- misc.mdのパスを作成
    local misc_file_path = archive_dir .. "/misc.md"

    -- misc.mdが存在するかチェック
    local misc_file_exists = vim.fn.filereadable(misc_file_path) == 1

    -- misc.mdを開く（存在しない場合は新規作成）
    local misc_file = io.open(misc_file_path, "a+")
    if not misc_file then
      print("Failed to open or create file: " .. misc_file_path)
      return
    end

    -- ファイルが新規作成された場合はヘッダーを追加
    if not misc_file_exists then
      misc_file:write("# " .. date .. " misc tasks\n\n")
    end

    -- ファイルの最後にタスクを追加（常に完了状態で追加）
    misc_file:write("- [x] " .. task_text .. "\n")
    misc_file:close()

    -- 現在のバッファから行を直接削除（完了状態への更新なし）
    vim.api.nvim_buf_set_lines(0, current_line_num - 1, current_line_num, false, {})
    print("Task archived to: " .. misc_file_path .. " and removed from original file")
  end
end, {})

-- create php file
vim.api.nvim_create_user_command("CreatePhp", function()
  local file_name = vim.fn.input("What is your file name: ")
  if file_name == "" then
    print("File name cannot be empty.")
    return
  end

  local current_dir = vim.fn.expand("%:p:h")
  local project_root = vim.fn.getcwd() -- プロジェクトのルートディレクトリを取得

  -- プロジェクトルートからの相対パスを計算
  local relative_path = string.sub(current_dir, #project_root + 14) -- +14は最初のofferbox-v2\を排除するため

  -- relative_path の各ディレクトリ名の頭文字を大文字にする関数
  local function capitalize_first_letter(str)
    return (str:gsub("^%l", string.upper))
  end

  -- namespaceを生成 (ディレクトリ区切りを '\' に置換し、頭文字を大文字にする)
  local namespace_parts = {}
  for part in string.gmatch(relative_path, "[^/]+") do
    table.insert(namespace_parts, capitalize_first_letter(part))
  end
  local namespace = table.concat(namespace_parts, "\\")

  local class_name = string.gsub(file_name, "[^a-zA-Z0-9_]", "") -- クラス名として安全な文字列に変換
  local file_path = current_dir .. "/" .. file_name .. ".php" -- ファイルパスはそのまま

  local lines = {
    "<?php",
    "",
    "declare(strict_types=1);",
    "",
    "namespace " .. namespace .. ";", -- namespace を追記 (末尾に ';' を追加)
    "",
    "final class " .. class_name,
    "{",
    "  public function __construct()",
    "  {",
    "  }",
    "}",
  }

  local file = io.open(file_path, "w")
  if file then
    for _, line in ipairs(lines) do
      file:write(line .. "\n")
    end
    file:close()
    vim.cmd("edit " .. vim.fn.fnameescape(file_path)) -- 作成したファイルを開く
  else
    print("Failed to create file: " .. file_path)
  end
end, {})

-- PHPStan integration
-- local phpstan_timers = {} -- デバウンス用のタイマーを管理
-- local phpstan_jobs = {}   -- 実行中のジョブを管理
--
-- local function run_phpstan(bufnr, delay)
--   delay = delay or 0 -- デフォルトは即座に実行
--
--   local filename = vim.api.nvim_buf_get_name(bufnr)
--
--   -- PHPファイル以外は処理しない
--   if not filename:match("%.php$") then
--     return
--   end
--
--   -- プロジェクト内のPHPファイルのみ処理
--   if not filename:match("/Users/erikomishina/www/offerbox/public_html/offerbox%-v2/") then
--     return
--   end
--
--   -- 既存のタイマーをキャンセル
--   if phpstan_timers[bufnr] then
--     vim.fn.timer_stop(phpstan_timers[bufnr])
--     phpstan_timers[bufnr] = nil
--   end
--
--   -- 既存のジョブをキャンセル
--   if phpstan_jobs[bufnr] then
--     vim.fn.jobstop(phpstan_jobs[bufnr])
--     phpstan_jobs[bufnr] = nil
--   end
--
--   local function execute_phpstan()
--     print("DEBUG: Starting phpstan run for " .. filename)
--     -- フルパスから相対パスに変換
--     local relative_path = filename:gsub("/Users/erikomishina/www/offerbox/public_html/offerbox%-v2/", "")
--     print("Running phpstan for: " .. relative_path)
--
--     local cmd = string.format(
--       "cd ~/www/offerbox/public_html/offerbox-v2 && docker compose exec -w /var/www/offerbox-v2 -T v2_php ./vendor/bin/phpstan analyse -l 9 -c phpstan.neon.dist --memory-limit=2G --no-progress --error-format=raw %s 2>/dev/null",
--       relative_path
--     )
--
--     local job_id = vim.fn.jobstart(cmd, {
--       stdout_buffered = true,
--       stderr_buffered = true,
--       on_stdout = function(_, data)
--         local diagnostics = {}
--
--         print("PHPStan stdout data received:")
--         if data then
--           for i, line in ipairs(data) do
--             print(string.format("  [%d]: %q", i, line))
--             if line ~= "" and not line:match("^Note:") and not line:match("^$") then
--               -- PHPStanのraw形式をパース: file:line:message
--               local file, line_num, message = line:match("^([^:]+):(%d+):(.+)$")
--
--               if file and line_num and message then
--                 print(string.format("Parsed - file: %s, line: %s, message: %s", file, line_num, message))
--                 -- パスを正規化
--                 local normalized_file =
--                   file:gsub("^/var/www/offerbox%-v2", "/Users/erikomishina/www/offerbox/public_html/offerbox-v2")
--                 print(string.format("Normalized file: %s", normalized_file))
--                 print(string.format("Current filename: %s", filename))
--
--                 -- 現在のファイルの診断のみ処理
--                 if normalized_file == filename then
--                   print("File matches! Adding diagnostic")
--                   table.insert(diagnostics, {
--                     lnum = tonumber(line_num) - 1, -- 0-based
--                     col = 0,
--                     severity = vim.diagnostic.severity.ERROR,
--                     source = "phpstan",
--                     message = "phpstan: " .. message:gsub("^%s*", ""), -- 先頭の空白を削除してプレフィックス追加
--                   })
--                 else
--                   print("File does not match current buffer")
--                 end
--               else
--                 print("Could not parse line: " .. line)
--               end
--             end
--           end
--         end
--
--         print(string.format("Setting %d diagnostics", #diagnostics))
--         -- 診断を設定
--         vim.diagnostic.set(vim.api.nvim_create_namespace("phpstan"), bufnr, diagnostics)
--       end,
--       on_stderr = function(_, data)
--         -- Docker compose警告は無視
--         if data then
--           for _, line in ipairs(data) do
--             if line ~= "" and not line:match("MOCK.*variable") and not line:match("version.*obsolete") then
--               print("PHPStan Error: " .. line)
--             end
--           end
--         end
--       end,
--       on_exit = function(_, exit_code)
--         -- ジョブ完了時にリストから削除
--         phpstan_jobs[bufnr] = nil
--
--         if exit_code == 0 then
--           -- エラーがない場合は診断をクリア
--           vim.diagnostic.set(vim.api.nvim_create_namespace("phpstan"), bufnr, {})
--           print("PHPStan: No issues found!")
--         end
--       end,
--     })
--
--     -- ジョブIDを保存
--     phpstan_jobs[bufnr] = job_id
--   end
--
--   -- デバウンス機能：指定された遅延後に実行
--   if delay > 0 then
--     phpstan_timers[bufnr] = vim.fn.timer_start(delay, function()
--       phpstan_timers[bufnr] = nil
--       execute_phpstan()
--     end)
--   else
--     execute_phpstan()
--   end
-- end
--
-- -- PHPファイルが開かれた時にphpstanを実行
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "php",
--   callback = function(ev)
--     local bufnr = ev.buf
--     print("PHP FileType detected for buffer: " .. bufnr)
--
--     -- すぐに実行
--     run_phpstan(bufnr)
--
--     -- 保存時に即座に実行
--     vim.api.nvim_create_autocmd("BufWritePost", {
--       buffer = bufnr,
--       callback = function()
--         run_phpstan(bufnr) -- 即座に実行
--       end,
--     })
--
--     -- テキスト変更時にデバウンス付きで実行（2秒後）
--     vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
--       buffer = bufnr,
--       callback = function()
--         run_phpstan(bufnr, 2000) -- 2秒のデバウンス
--       end,
--     })
--
--     -- インサートモードを出た時に短いデバウンス付きで実行（500ms後）
--     vim.api.nvim_create_autocmd("InsertLeave", {
--       buffer = bufnr,
--       callback = function()
--         run_phpstan(bufnr, 500) -- 500msのデバウンス
--       end,
--     })
--   end,
-- })
