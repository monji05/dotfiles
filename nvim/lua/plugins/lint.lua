return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    -- PHP
    -- local phpcs = lint.linters.phpcs
    -- phpcs.cmd = "vendor/bin/phpcs"
    -- phpcs.stdin = false
    -- phpcs.args = {
    --   "--standard=PSR12",
    --   "--report=json",
    --   "-q",
    -- }
    --
    -- lint.linters_by_ft = {
    --   php = { "phpcs" },
    -- }
    --

    local phpstan = lint.linters.phpstan

    local cspell = lint.linters.cspell
    cspell.args = { "--config=~/.config/cspell/cspell.json" }

    lint.linters_by_ft = {
      php = { "phpcs", "cspell" },
      lua = { "cspell" },
      markdown = { "cspell" },
      neorg = { "cspell" },
      json = { "cspell" },
    }

    local nvim_config_dir = "~/.config/nvim/"
    local cspell_config_dir = "~/.config/cspell/"
    local cspell_files = {
      config = vim.call("expand", cspell_config_dir .. "/cspell.json"),
      user = vim.call("expand", nvim_config_dir .. "/cspell.txt"),
    }

    local cspell_append = function(opts)
      local word = opts.args
      if not word or word == "" then
        -- 引数がなければcwordを取得
        word = vim.call("expand", "<cword>"):lower()
      end

      local dictionary_name = "user"

      -- shellのechoコマンドで辞書ファイルに追記
      io.popen("echo " .. word .. " >> " .. cspell_files[dictionary_name])

      -- 追加した単語および辞書を表示
      vim.notify('"' .. word .. '" is appended to ' .. dictionary_name .. " dictionary.", vim.log.levels.INFO, {})

      -- cspellをリロードするため、現在行を更新してすぐ戻す
      if vim.api.nvim_get_option_value("modifiable", {}) then
        vim.api.nvim_set_current_line(vim.api.nvim_get_current_line())
        vim.api.nvim_command("silent! undo")
      end
    end

    vim.api.nvim_create_user_command("CSpellAppend", cspell_append, { nargs = "?", bang = true })

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
