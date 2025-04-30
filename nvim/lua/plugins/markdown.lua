return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "mpas/marp-nvim",
    keys = { "<leader>mt", "<leader>ms" },
    config = function()
      require("marp").setup({
        port = 8081,
        wait_for_response_timeout = 30,
        wait_for_response_delay = 1,
      })
      vim.keymap.set("n", "<leader>mt", "<cmd>MarpToggle<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ms", "<cmd>MarpStatus<cr>", { noremap = true, silent = true })
    end,
  },
  {
    -- require bun, bun install pantsdown
    "wallpants/github-preview.nvim",
    cmd = { "GithubPreviewToggle" },
    keys = { "<leader>mpt" },
    opts = {
      -- config goes here
    },
    config = function(_, opts)
      local gpreview = require("github-preview")
      gpreview.setup(opts)

      local fns = gpreview.fns
      vim.keymap.set("n", "<leader>mpt", fns.toggle)
      vim.keymap.set("n", "<leader>mps", fns.single_file_toggle)
      vim.keymap.set("n", "<leader>mpd", fns.details_tags_toggle)
    end,
  },
}
