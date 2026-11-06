require("trouble").setup({})

local map = vim.keymap.set
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
map(
  "n",
  "<leader>cl",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "LSP Definitions / references / ... (Trouble)" }
)
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- phpstan
local Job = require("plenary.job")

local M = {}

local namespace = vim.api.nvim_create_namespace("pream90.phpstan")

M.analyse = function()
  local phpstan = "./vendor/bin/phpstan"
  if vim.fn.executable(phpstan) == 0 then
    return
  end
  Job:new({
    command = phpstan, -- FIX: use v2_php
    args = {
      "analyse",
      "--level=9",
      "-c",
      "./phpstan.neon.dist",
      "--error-format=json",
      vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
    },
    cwd = vim.fn.getcwd(),
    on_exit = vim.schedule_wrap(function(j, return_val)
      if return_val == 0 then
        return
      end
      local result = j:result()
      local ok, response = pcall(vim.json.decode, table.concat(result, "\n"))
      if not ok or type(response) ~= "table" or not response.files then
        return
      end
      for file_path in pairs(response.files) do
        local bufnr = vim.fn.bufnr(file_path)
        local diagnostics = {}

        for i in pairs(response.files[file_path].messages) do
          local message = response.files[file_path].messages[i]
          local diagnostic = {
            bufnr = bufnr,
            lnum = message.line,
            col = 0,
            message = message.message,
            source = message.tip,
            code = message.identifier,
            namespace = namespace,
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
  }):start()
end

M.setup = function()
  -- Registering auto command to the files that ends with the php extension
  vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
    pattern = { "*.php" },
    callback = M.analyse,
  })
end

M.setup()
