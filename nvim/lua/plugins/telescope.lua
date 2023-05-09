return {
  "nvim-telescope/telescope.nvim",
  keys = { ";f", ";r", "\\", ";;", "<leader>f", "<leader>z" },
  cmd = "Telescope",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-z.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local fb_actions = telescope.extensions.file_browser.actions

    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
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
      },
      extensions = {
        file_browser = {
          initial_mode = "normal",
          cwd = "absolute",
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
              ["N"] = fb_actions.create,
              ["o"] = actions.select_tab,
              ["h"] = fb_actions.goto_parent_dir,
              ["H"] = fb_actions.toggle_hidden,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
            },
          },
        },
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
    vim.keymap.set("n", ";r", function()
      builtin.live_grep()
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
  end,
}
