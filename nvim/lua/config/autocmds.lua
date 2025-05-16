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
