return {
  "smjonas/inc-rename.nvim",
  opts = function()
    vim.keymap.set("n", "gr", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true })
  end,
}
