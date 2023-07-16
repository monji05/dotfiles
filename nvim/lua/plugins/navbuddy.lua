local navbuddy = require("nvim-navbuddy")
local actions = require("nvim-navbuddy.actions")
local kind = require("config.icons").get("kind")

navbuddy.setup {
  window = {
    border = "single", -- "rounded", "double", "solid", "none" -- or an array with eight chars building up the border in a clockwise fashion
    -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
    size = "70%",      -- Or table format example: { height = "40%", width = "100%"}
    position = "50%",  -- Or table format example: { row = "100%", col = "0%"}
    scrolloff = nil,   -- scrolloff value within navbuddy window
    node_markers = {
      enabled = true,
      icons = {
        leaf = "  ",
        leaf_selected = " → ",
        branch = " ",
      },
    },
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
  use_default_mappings = true,
  mappings = {
    ["<esc>"] = actions.close(), -- Close and cursor to original location
    ["q"] = actions.close(),

    ["j"] = actions.next_sibling(),     -- down
    ["k"] = actions.previous_sibling(), -- up

    ["h"] = actions.parent(),           -- Move to left panel
    ["l"] = actions.children(),         -- Move to right panel
    ["0"] = actions.root(),             -- Move to first panel

    ["v"] = actions.visual_name(),      -- Visual selection of name
    ["V"] = actions.visual_scope(),     -- Visual selection of scope

    ["y"] = actions.yank_name(),        -- Yank the name to system clipboard "+
    ["Y"] = actions.yank_scope(),       -- Yank the scope to system clipboard "+

    ["i"] = actions.insert_name(),      -- Insert at start of name
    ["I"] = actions.insert_scope(),     -- Insert at start of scope

    ["a"] = actions.append_name(),      -- Insert at end of name
    ["A"] = actions.append_scope(),     -- Insert at end of scope

    ["r"] = actions.rename(),           -- Rename currently focused symbol

    ["d"] = actions.delete(),           -- Delete scope

    ["f"] = actions.fold_create(),      -- Create fold of current scope
    ["F"] = actions.fold_delete(),      -- Delete fold of current scope

    ["c"] = actions.comment(),          -- Comment out current scope

    ["<enter>"] = actions.select(),     -- Goto selected symbol
    ["o"] = actions.select(),

    ["J"] = actions.move_down(), -- Move focused node down
    ["K"] = actions.move_up(),   -- Move focused node up

    ["t"] = actions.telescope({  -- Fuzzy finder at current level.
      layout_config = {          -- All options that can be
        height = 0.60,           -- passed to telescope.nvim's
        width = 0.60,            -- default can be passed here.
        prompt_position = "top",
        preview_width = 0.50
      },
      layout_strategy = "horizontal"
    }),

    ["g?"] = actions.help(), -- Open mappings help window
  },
}
