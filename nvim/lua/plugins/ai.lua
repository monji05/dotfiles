return {
  {
    -- This plugin is the pure lua replacement for github/copilot.vim.
    -- "zbirenbaum/copilot.lua",
    -- event = "InsertEnter",
    -- opts = function()
    --   require("copilot.api").status = require("copilot.status")
    -- end,
  },
  {
    -- "olimorris/codecompanion.nvim",
    -- cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat" },
    -- keys = {
    --   { "<Space>cc", "<Cmd>CodeCompanionChat Toggle<CR>", mode = { "n" } },
    --   { "<Space>cc", "<Cmd>CodeCompanionChat<CR>", mode = { "v" } },
    --   { "<Space>ca", "<Cmd>CodeCompanionActions<CR>", mode = { "n", "x" } },
    -- },
    -- dependencies = {
    --   "nvim-lua/plenary.nvim",
    --   "nvim-treesitter/nvim-treesitter",
    -- },
    -- opts = {
    --   opts = {
    --     language = "Japanese",
    --   },
    --   display = {
    --     chat = {
    --       show_header_separator = true,
    --     },
    --   },
    --   adapters = {
    --     copilot = function()
    --       return require("codecompanion.adapters").extend("copilot", {
    --         schema = {
    --           model = {
    --             default = "claude-3.7-sonnet",
    --           },
    --         },
    --       })
    --     end,
    --   },
    --   inline = {
    --     adapter = "copilot",
    --   },
    --   strategies = {
    --     chat = {
    --       adapter = "copilot",
    --       roles = {
    --         llm = function(adapter)
    --           return "  CodeCompanion (" .. adapter.formatted_name .. ")"
    --         end,
    --         user = "  Me",
    --       },
    --     },
    --   },
    -- },
  },
}
