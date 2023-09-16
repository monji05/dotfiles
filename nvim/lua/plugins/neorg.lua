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
  },
})
