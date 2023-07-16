local navbuddy = require("nvim-navbuddy")
local actions = require("nvim-navbuddy.actions")
local kind = require("config.icons").get("kind")

navbuddy.setup {
  window = {
    border = "single", -- "rounded", "double", "solid", "none"
    -- or an array with eight chars building up the border in a clockwise fashion
    -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
    size = "70%",     -- Or table format example: { height = "40%", width = "100%"}
    position = "50%", -- Or table format example: { row = "100%", col = "0%"}
    scrolloff = nil,  -- scrolloff value within navbuddy window
    sections = {
      left = {
        size = "30%",
        border = nil, -- You can set border style for each section individually as well.
      },
      mid = {
        size = "40%",
        border = nil,
      },
      right = {
        -- No size option for right most section. It fills to
        -- remaining area.
        border = nil,
        preview = "leaf", -- Right section can show previews too.
        -- Options: "leaf", "always" or "never"
      }
    },
  },
  icons = {
    File          = kind.File,
    Module        = kind.Module,
    Namespace     = kind.Namespace,
    Package       = kind.Package,
    Class         = kind.class,
    Method        = kind.Method,
    Property      = kind.Property,
    Field         = kind.Field,
    Constructor   = kind.Constructor,
    Enum          = kind.Enum,
    Interface     = kind.Interface,
    Function      = kind.Function,
    Variable      = kind.Variable,
    Constant      = kind.Constant,
    String        = kind.String,
    Number        = kind.Number,
    Boolean       = kind.Boolean,
    Array         = kind.Array,
    Object        = kind.Object,
    Key           = kind.Keyword,
    Null          = kind.Null,
    EnumMember    = kind.EnumMember,
    Struct        = kind.Struct,
    Event         = kind.Event,
    Operator      = kind.Operator,
    TypeParameter = kind.TypeParameter,
  },
}

local opts = { silent = true, noremap = true }
-- not works
vim.api.nvim_keymap_set("n", "<leader>dy", ":lua require('nvim-navbuddy').open()", opts)
