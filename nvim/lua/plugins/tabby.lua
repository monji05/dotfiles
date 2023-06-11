return {
  "nanozuki/tabby.nvim",
  config = function()
    require("tabby.tabline").set(function(line, theme)
      theme = {
        fill = "TabLineFill", --tabline background
        head = "TabLine", -- head element highlight
        current_tab = { bg = "#719e07", fg = "#002b36", style = "italic" }, -- current tab label highlight
        tab = "TabLine", -- other tab label highlight
        win = "TabLine", -- window highlight
        tail = "TabLine", -- tail element highlight
      }
      return {
        {
          { "  ", hl = theme.head },
          line.sep(" ", theme.head, theme.fill),
        },
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab
          return {
            line.sep(" ", hl, theme.fill),
            tab.is_current() and "" or "",
            tab.number(),
            tab.name(),
            -- tab.close_btn(''), -- show a close button
            line.sep(" ", hl, theme.fill),
            hl = hl,
            margin = " ",
          }
        end),
        line.spacer(),
        {
          line.sep(" ", theme.tail, theme.fill),
          { "  ", hl = theme.tail },
        },
        hl = theme.fill,
      }
    end)
    vim.api.nvim_set_keymap("n", "te", ":$tabnew<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
    -- I won't use this .
    -- vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<Tab>", ":tabn<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<S-Tab>", ":tabp<CR>", { noremap = true })
    -- move current tab to previous position
    vim.api.nvim_set_keymap("n", "<leader><left>", ":-tabmove<CR>", { noremap = true })
    -- move current tab to next position
    vim.api.nvim_set_keymap("n", "<leader><right>", ":+tabmove<CR>", { noremap = true })
  end,
}
