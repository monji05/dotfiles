local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local fb_actions = telescope.extensions.file_browser.actions
local ui = require("config.icons").get("ui")
local lga_actions = require("telescope-live-grep-args.actions")

require("file_history").setup({
  -- This is the location where it will create your file history repository
  backup_dir = "~/.file-history-git",
  -- command line to execute git
  git_cmd = "git",
})
require("telescope").load_extension("recent_files")

telescope.setup({
  defaults = {
    prompt_prefix = ui.Telescope,
    selection_caret = ui.selection_caret,
    prompt_title = "Find File",
    mappings = {
      n = {
        ["q"] = actions.close,
        ["o"] = actions.select_tab,
      },
      i = {
        ["<C-u>"] = false,
        ["<C-o>"] = actions.select_tab,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
  },
  extensions = {
    file_browser = {
      initial_mode = "normal",
      theme = "ivy",
      prompt_path = true,
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = false,
      display_stat = { date = false, size = false },
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function()
            vim.cmd("normal vbd")
          end,
          ["<C-o>"] = actions.select_tab,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["n"] = fb_actions.create,
          ["o"] = actions.select_tab,
          ["h"] = fb_actions.goto_parent_dir,
          ["H"] = fb_actions.toggle_hidden,
          ["/"] = function()
            vim.cmd("startinsert")
          end,
        },
      },
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = {         -- extend mappings
        i = {
          ["<C-q>"] = lga_actions.quote_prompt(),
          ["<C-Q>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    },
    recent_files = {},
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
})

vim.keymap.set("n", ";f", function()
  builtin.find_files({
    no_ignore = false,
    hidden = true,
  })
end)
vim.keymap.set("n", "\\\\", function()
  builtin.buffers()
end)
vim.keymap.set("n", ";t", function()
  builtin.help_tags()
end)
vim.keymap.set("n", ";;", function()
  builtin.resume()
end)
vim.keymap.set("n", ";e", function()
  builtin.diagnostics()
end)
vim.keymap.set("n", "go", function()
  builtin.oldfiles()
end)
vim.api.nvim_set_keymap(
  "n",
  "<leader>f",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true }
)

vim.api.nvim_set_keymap("n", "<leader>z", "<Cmd>Telescope z list<CR>", { noremap = true })

-- must call load_extension after set up function:
telescope.load_extension("file_browser")
telescope.load_extension("z")
telescope.load_extension("fzf")
telescope.load_extension("file_history")
telescope.load_extension("live_grep_args")

vim.api.nvim_set_keymap("n", "<leader>th", "<Cmd>Telescope file_history history<CR>", { noremap = true })
vim.api.nvim_set_keymap(
  "n",
  "<Leader><Leader>",
  "<cmd>lua require('telescope').extensions.recent_files.pick()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", ";r",
  "<Cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { noremap = true, silent = true })
