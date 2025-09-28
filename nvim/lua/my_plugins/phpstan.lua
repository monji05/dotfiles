-- NOTE: https://dev.to/praem90/create-a-neovim-plugin-for-a-cli-tool-37fm

local Job = require("plenary.job")

local M = {}

local namespace = vim.api.nvim_create_namespace("phpstan")

M.analyse = function()
  local original_file = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local current_file = original_file

  -- */app/の*部分をトリム（app/以下のパスに変換）
  local app_path = string.match(current_file, ".*/app/(.*)")
  if app_path then
    current_file = "app/" .. app_path
  end

  Job
    :new({
      command = "docker",
      args = {
        "compose",
        "exec",
        "-w",
        "/var/www/offerbox-v2",
        "-T",
        "v2_php",
        "./vendor/bin/phpstan",
        "analyse",
        "--level=9",
        "-c",
        "./phpstan.neon.dist",
        "--memory-limit=2G",
        "--error-format=json",
        current_file,
      },
      cwd = vim.fn.getcwd(),
      on_exit = vim.schedule_wrap(function(j, return_val)
        if return_val == 0 then
          vim.diagnostic.set(namespace, vim.api.nvim_get_current_buf(), {})
          return
        end

        local result = j:result()

        if #result == 0 or not result[1] then
          return
        end

        local success, response = pcall(vim.json.decode, result[1])
        if not success then
          return
        end
        for file_path in pairs(response.files or {}) do
          -- コンテナパスからローカルパスに逆変換
          local local_file_path = string.gsub(
            file_path,
            "/var/www/offerbox%-v2/",
            "/Users/erikomishina/www/offerbox/public_html/offerbox-v2/"
          )
          local bufnr = vim.fn.bufnr(local_file_path)
          local diagnostics = {}

          for i in pairs(response.files[file_path].messages) do
            local message = response.files[file_path].messages[i]
            local diagnostic = {
              bufnr = bufnr,
              lnum = message.line - 1, -- 0ベースに変換
              col = 0,
              message = message.message,
              source = "phpstan",
              code = message.identifier,
            }

            if message.ignorable then
              diagnostic.severity = vim.diagnostic.severity.WARN
            else
              diagnostic.severity = vim.diagnostic.severity.ERROR
            end

            table.insert(diagnostics, diagnostic)
          end

          vim.diagnostic.set(namespace, bufnr, diagnostics)
        end
      end),
    })
    :start()
end

M.setup = function()
  -- Registering auto command to the files that ends with the php extension
  vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
    pattern = { "/Users/erikomishina/www/offerbox/public_html/offerbox-v2/*.php" },
    callback = M.analyse,
  })
end

return M
