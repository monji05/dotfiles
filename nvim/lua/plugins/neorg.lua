require("neorg").setup({
  load = {
    ["core.defaults"] = {},  -- Loads default behaviour
    ["core.concealer"] = {}, -- Adds pretty icons to your documents
    ["core.dirman"] = {      -- Manages Neorg workspaces
      config = {
        workspaces = {
          neorg_notes = "~/neorg_notes",
        },
        default_workspace = "neorg_notes",
      },
    },
    ["core.export"] = {
      config = {
        public = {
          export_dir = "output"
        }
      },
    },
    ["external.exec"] = {},
    ["core.integrations.telescope"] = {},
    ["external.context"] = {},
    ["external.templates"] = {
      config = {
        templates_dir = "~/neorg_notes/templates"
      }
    },
    ["core.completion"] = {
      config = { engine = "nvim-cmp" },
    },
    ["core.integrations.nvim-cmp"] = {},
    ["core.qol.todo_items"] = {},
    -- ["core.tempus"] = {},
    -- ["core.ui.calendar"] = {}
  },
})

local neorg_callbacks = require("neorg.core.callbacks")

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
  -- Map all the below keybinds only when the "norg" mode is active
  keybinds.map_event_to_mode("norg", {
    n = { -- Bind keys in normal mode
      { "<C-f>", "core.integrations.telescope.find_linkable" },
    },

    i = { -- Bind in insert mode
      { "<C-p>", "core.integrations.telescope.insert_link" },
    },
  }, {
    silent = true,
    noremap = true,
  })
end)
