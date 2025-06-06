return {
  desc = "Set colored highlights for PHPStan results",
  constructor = function()
    return {
      on_exit = function(self, task, code)
        local output = table.concat(task:get_output(), "\n")

        if code == 0 and (output:match("OK no errors") or output:match("%[OK%]")) then
          -- 成功時：緑バー
          vim.cmd([[
            highlight OverseerTaskSuccess guibg=#10b981 guifg=#ffffff ctermbg=green ctermfg=white
            sign define OverseerTaskSuccess text=✓ texthl=OverseerTaskSuccess
          ]])
          task.status = "SUCCESS"
          vim.notify("PHPStan: OK no errors! ✓", vim.log.levels.INFO)
        elseif code ~= 0 or output:match("errors?") then
          -- エラー時：赤バー
          vim.cmd([[
            highlight OverseerTaskError guibg=#dc2626 guifg=#ffffff ctermbg=red ctermfg=white
            sign define OverseerTaskError text=✗ texthl=OverseerTaskError
          ]])
          task.status = "FAILURE"
          vim.notify("PHPStan: Errors found! ✗", vim.log.levels.ERROR)
        end
      end,
    }
  end,
}

-- return {
--   name = "phpstan",
--   builder = function()
--     return {
--       cmd = { "phpstan" },
--       args = {
--         "analyze",
--         "-l", "9",
--         "-c", "./phpstan.neon.dist",
--         "--memory-limit=2G",
--         "--no-progress"
--       },
--       cwd = vim.fn.getcwd(),
--       components = {
--         { "on_output_quickfix", open = true },
--         "on_result_diagnostics",
--         "on_exit_set_status",
--         "display_duration",
--         "phpstan_highlight", -- カスタムハイライトコンポーネント
--       },
--     }
--   end,
--   condition = {
--     filetype = { "php" },
--   },
-- }
