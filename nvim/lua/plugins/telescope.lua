return {
  "nvim-telescope/telescope.nvim",
  keys = { ";f", ";r", "\\", ";;", "<leader>f" },
  cmd = "Telescope",
  dependencies = "nvim-telescope/telescope-file-browser.nvim",
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local fb_actions = telescope.extensions.file_browser.actions

    telescope.setup({
      defaults = {
        mappings = {
          n = {
            ["q"] = actions.close,
            ["o"] = actions.select_tab,
          },
          i = {
            ["<C-u>"] = false,
          },
        },
      },
      extensions = {
        file_browser = {
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

    -- must call load_extension after set up function:
    telescope.load_extension("file_browser")
  end,
}
