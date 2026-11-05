-- lua/config/plugins/snacks.lua
-- Ported from the lazy.nvim spec (opts / keys / init). Loaded from config/plugins.lua.

local Snacks = require("snacks")

Snacks.setup({
  terminal = {
    win = {
      position = "float",
      border = "rounded", -- "none", "single", "double", "rounded", ...
      width = 0, -- full screen width
      height = 0, -- full screen height
    },
  },
  explore = { enable = false },
  picker = {
    enable = true,
    ui_select = true,
    sources = {
      files = { hidden = true, cmd = "fd" },
      grep = { hidden = true, cmd = "rg", regex = true },
    },
  },
  bigfile = { enabled = true },
  toggle = {
    map = vim.keymap.set,
    which_key = true,
    notify = true,
    icon = { enabled = " ", disabled = " " },
    color = { enabled = "green", disabled = "yellow" },
  },
  statuscolumn = {
    enabled = true,
    left = { "mark", "sign" },
    right = { "fold", "git" },
    folds = { open = false, git_hl = false },
    git = { patterns = { "GitSign" } },
    refresh = 50,
  },
  notifier = {
    enabled = true,
    timeout = 3000,
    top_down = false,
  },
  quickfile = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = { wo = { wrap = true } },
  },
  indent = { enabled = false },
  lazygit = { enabled = true },
})

-- ---------------------------------------------------------------- keymaps
local map = vim.keymap.set

map("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
map("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Open notifications history" })

-- git
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
map("n", "<leader>gB", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
map({ "n", "v" }, "<leader>gb", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
map("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
map("n", "<leader>gl", function() Snacks.lazygit.log() end, { desc = "Lazygit Log (cwd)" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })

-- terminal
map("n", "<c-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
map("n", "<c-_>", function() Snacks.terminal() end, { desc = "which_key_ignore" })

-- word references
map({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
map({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

-- neovim news
map("n", "<leader>N", function()
  Snacks.win({
    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
    width = 0.6,
    height = 0.6,
    wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 },
  })
end, { desc = "Neovim News" })

-- pickers
map("n", ";f", function() Snacks.picker.files() end, { desc = "File Picker" })
map("n", ";r", function() Snacks.picker.grep() end, { desc = "Grep source" })
map("n", ";b", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", ";g", function() Snacks.picker.git_branches() end, { desc = "Open git branches" })
map("n", ";w", function() Snacks.picker.grep_word() end, { desc = "Grep word" })
map("n", ";;", function() Snacks.picker.resume() end, { desc = "Open last picker" })
map("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
map("n", "<leader>cl", function() Snacks.picker.cliphist() end, { desc = "Open clip history" })

-- ------------------------------------------- debug globals + toggles
-- (was an `init` callback on the VeryLazy event; run right after startup instead)
vim.schedule(function()
  _G.dd = function(...) Snacks.debug.inspect(...) end
  _G.bt = function() Snacks.debug.backtrace() end
  vim.print = _G.dd -- use snacks for the `:=` command

  Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
  Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
  Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
  Snacks.toggle.diagnostics():map("<leader>ud")
  Snacks.toggle.line_number():map("<leader>ul")
  Snacks.toggle
    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
    :map("<leader>uc")
  Snacks.toggle.treesitter():map("<leader>uT")
  Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
  Snacks.toggle.inlay_hints():map("<leader>uh")
end)
