local git = require("config.icons").get("git")
require("gitsigns").setup({
  signs = {
    add = { hl = "GitSignsAdd", text = git.add, numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = git.change, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = git.delete, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = git.topdelete, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = {
      hl = "GitSignsChange",
      text = git.changedelete,
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
    untracked = { hl = "GitSignsAdd", text = git.untracked, numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
  },
  signcolumn = true,
  numhl = false,  -- diff highlight line number
  linehl = false, -- diff highlight line
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    map("n", "<Space>d", ":Gitsigns diffthis<CR>")
    map("n", "<Space>h", gs.preview_hunk)
    map("n", "<leader>b", "<CMD>Gitsigns blame_line<CR>")
  end,
})
