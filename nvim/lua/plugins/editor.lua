require("mini.diff").setup({
  view = {
    -- show whole reference part above whole buffer part, as in `git diff`
    overlay_style = "hunk",
  },
})

require("codediff").setup({
  explorer = {
    auto_open_on_cursor = true, -- auto-open diff for file under cursor while moving
    auto_open_debounce_ms = 80, -- debounce window (ms) for the above
    view_mode = "tree",
  },
})

vim.keymap.set("n", "<leader>do", "<CMD>CodeDiff<CR>", { desc = "CodeDiff" })

require("hlchunk").setup({
  chunk = {
    enable = true,
  },
  indent = {
    enable = true,
    chars = { "▏" },
    -- solarized-osaka
    style = "#073642",
  },
})

-- very useful: join / split things in brackets, function args, ...
-- (no default keymaps; use :TSJToggle / :TSJSplit / :TSJJoin)
require("treesj").setup({ use_default_keymaps = false })

require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "▎" },
    topdelete = { text = "▎" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
    end

    map("n", "]c", gs.next_hunk, "Next Hunk")
    map("n", "[c", gs.prev_hunk, "Prev Hunk")
    map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    map("n", "<leader>h", gs.preview_hunk, "Preview Hunk")
  end,
})

-- Convenience file operations (copy path, rename, move, create, duplicate)
do
  local keymap = vim.keymap.set
  local genghis = require("genghis")
  -- the function name changed between versions (copyFilePath / copyFilepath)
  keymap("n", "<leader>yP", genghis.copyFilepath or genghis.copyFilePath, { desc = "Copy absolute path" })
  keymap("n", "<leader>yp", genghis.copyRelativePath, { desc = "Copy relative path" })
  keymap("n", "<leader>rf", genghis.renameFile, { desc = "Rename file" })
  keymap("n", "<leader>mf", genghis.moveAndRenameFile, { desc = "Move and rename file" })
  keymap("n", "<leader>nf", genghis.createNewFile, { desc = "New file" })
  keymap("n", "<leader>yf", genghis.duplicateFile, { desc = "Duplicate file" })
end

require("numb").setup({})
