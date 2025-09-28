return {
  {
    "custom/phpstan",
    dir = vim.fn.stdpath("config") .. "/lua/my_plugins",
    ft = "php", -- PHP ファイルでのみ読み込み
    config = function()
      local phpstan = require("my_plugins.phpstan")
      phpstan.setup()

      -- 手動実行用のコマンド
      vim.api.nvim_create_user_command("PHPStan", function()
        phpstan.analyse()
      end, { desc = "PHPStan解析を実行" })
    end,
  },
}
