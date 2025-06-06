return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerRunCmd", "OverseerToggle", "OverseerTaskAction" },
  opts = {
    templates = { "builtin", "phpstan" },
  },
  keys = {
    "<leader>ps",
    "<CMD>OverseerRun phpstan<CR>",
    desc = { "Run PHPStan" },
  },
}
