local toggle_key = "<C-,>"

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
    },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
  opts = {
    terminal = {
      provider = "snacks",
      snacks_win_opts = {
        position = "float",
        border = "rounded",
        width = 0.9,
        height = 0.9,
        wo = {
          scrolloff = 0,
        },
        keys = {
          claude_hide = {
            toggle_key,
            function(self)
              self:hide()
            end,
            mode = "t",
            desc = "Hide",
          },
          -- ターミナルモードでのスクロール
          scroll_up = {
            "<C-u>",
            function()
              -- ノーマルモードに切替 → スクロール → ターミナルモードに戻る
              local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n><C-u>", true, false, true)
              vim.api.nvim_feedkeys(keys, "n", false)
            end,
            mode = "t",
            desc = "Scroll up",
          },
          scroll_down = {
            "<C-d>",
            function()
              local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n><C-d>", true, false, true)
              vim.api.nvim_feedkeys(keys, "n", false)
            end,
            mode = "t",
            desc = "Scroll down",
          },
          -- マウスホイールでのスクロール
          mouse_scroll_up = {
            "<ScrollWheelUp>",
            function()
              local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n><ScrollWheelUp>", true, false, true)
              vim.api.nvim_feedkeys(keys, "n", false)
            end,
            mode = "t",
            desc = "Mouse scroll up",
          },
          mouse_scroll_down = {
            "<ScrollWheelDown>",
            function()
              local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n><ScrollWheelDown>", true, false, true)
              vim.api.nvim_feedkeys(keys, "n", false)
            end,
            mode = "t",
            desc = "Mouse scroll down",
          },
        },
      },
    },
  },
}
