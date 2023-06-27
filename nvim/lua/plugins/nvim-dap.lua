local dap = require 'dap'
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
}

dap.configurations.php = {
  {
    name             = "OfferBox v1",
    type             = "php",
    request          = "launch",
    port             = 9000,
    pathMappings = {
      ["/var/www/offerbox"] = "${workspaceFolder}"
    },
  },
  {
    name             = "OfferBox v2",
    type             = "php",
    request          = "launch",
    port             = 9000,
    pathMappings = {
      ["/var/www/offerbox/offerbox-v2"] = "${workspaceFolder}/offerbox-v2"
    },
  }
}

vim.api.nvim_set_keymap('n', '<F5>', ':DapContinue<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F6>', ':DapStepInto<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':DapStepOver<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':DapStepOut<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>db', ':DapToggleBreakpoint<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require("dap").run_last()<CR>', { silent = true })
