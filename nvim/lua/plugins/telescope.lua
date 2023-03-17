return {
  'nvim-telescope/telescope.nvim',
  keys = { ';f', ';r', '\\', ';;' },
  cmd = 'Telescope',
  dependencies = "nvim-telescope/telescope-file-browser.nvim",
  config = function()
    local status, telescope = pcall(require, "telescope")
    if (not status) then return end
    local actions = require('telescope.actions')
    local builtin = require("telescope.builtin")

    local function telescope_buffer_dir()
      return vim.fn.expand('%:p:h')
    end

    telescope.setup {
      defaults = {
        mappings = {
          n = {
            ["q"] = actions.close
          },
        },
        file_ignore_patterns = {
          "node_modules",
          ".git/*",
          "packages",
          ".vscode",
          "tmp",
          "vendor",
          "docs"
        }
      },
    }

    vim.keymap.set('n', ';f',
      function()
        builtin.find_files({
          no_ignore = false,
          hidden = true
        })
      end)
    vim.keymap.set('n', ';r', function()
      builtin.live_grep()
    end)
    vim.keymap.set('n', '\\\\', function()
      builtin.buffers()
    end)
    vim.keymap.set('n', ';t', function()
      builtin.help_tags()
    end)
    vim.keymap.set('n', ';;', function()
      builtin.resume()
    end)
    vim.keymap.set('n', ';e', function()
      builtin.diagnostics()
    end)
    vim.keymap.set('n', 'go', function()
      builtin.oldfiles()
    end)
  end
}
