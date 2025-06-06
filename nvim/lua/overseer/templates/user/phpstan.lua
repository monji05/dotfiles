return {
  name = "phpstan",
  builder = function()
    return {
      cmd = { "phpstan" },
      args = { "analyse", "--no-progress" },
      cwd = vim.fn.getcwd(),
      env = {
        APP_ENV = "local",
      },
      components = {
        { "on_output_quickfix", open = true },
        "on_result_diagnostics",
        "on_exit_set_status",
        "display_duration",
      },
    }
  end,
  condition = {
    filetype = { "php" },
    callback = function()
      return vim.fn.filereadable("phpstan.neon") == 1 or vim.fn.filereadable("phpstan.neon.dist") == 1
    end,
  },
}
