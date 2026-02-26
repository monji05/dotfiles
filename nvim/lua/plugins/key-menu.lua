return {
  {
    "emmanueltouzery/key-menu.nvim",
    config = function()
      local keymap = vim.keymap.set

      -- key-menu.nvim
      vim.o.timeoutlen = 300
      local key_menu = require("key-menu")

      -- If you use <Space> as your mapping prefix, then this will make the key-menu
      -- popup appear in Normal mode, after you press <Space>, after timeoutlen.
      key_menu.set("n", "<leader>")

      -- Use the desc option to Vim's built-in vim.keymap.set to describe mappings.
      keymap("n", "<Space>w", "<Cmd>w<CR>", { desc = "Save" })
      keymap("n", "<Space>q", "<Cmd>q<CR>", { desc = "Quit" })
      keymap("n", "<Space>Q", "<Cmd>qa<CR>", { desc = "Quit all" })

      -- You can also pass Lua functions to vim.keymap.set.
      local erase_all_lines = function()
        vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
      end
      keymap("n", "<Space>k", erase_all_lines, { desc = "Erase all" })

      -- To describe the group of mappings under <Space>g, use key-menu.set.
      key_menu.set("n", "<Space>g", { desc = "Git" })
    end,
  },
}
