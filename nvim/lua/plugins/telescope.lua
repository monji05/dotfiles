return {
  "nvim-telescope/telescope.nvim",
  keys = { ";f", ";r", "\\", ";;" },
  cmd = "Telescope",
  dependencies = "nvim-telescope/telescope-file-browser.nvim",
  config = function()
    local telescope = require("telescope")

    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        mappings = {
          n = {
            ["q"] = actions.close,
            ["tt"] = actions.select_tab,
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
  end,
}
