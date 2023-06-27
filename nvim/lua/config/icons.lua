local icons = {}

local data = {
  kind = {
    Class = "󰠱",
    Color = "󰏘",
    Constant = "󰏿",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "󰇽",
    File = "󰈙",
    Folder = "󰉋",
    Function = "󰊕",
    Interface = "",
    Keyword = "󰌋",
    Method = "󰆧",
    Module = "",
    Namespace = "󰌗",
    Number = "",
    Operator = "󰆕",
    Package = "",
    Property = "󰜢",
    Reference = "",
    Snippet = "",
    Struct = "",
    Text = "󰉿",
    TypeParameter = "󰅲",
    Undefined = "",
    Unit = "",
    Value = "󰎠",
    Variable = "",
    -- ccls-specific icons.
    TypeAlias = "",
    Parameter = "",
    StaticMethod = "",
    Macro = "",
    Array = "󰅪",
    Boolean = "",
    Null = "󰟢",
    Object = "󰅩",
    String = "󰉿",
  },
  diagnostics = {
    error = " ",
    warn = " ",
    hint = " ",
    info = " ",
    header = "   ",
    preview = " ",
    finder_definition = "  ",
    finder_reference = "  ",
    rename_prompt_prefix = "➤",
    prefix = "●",
  },
  git = {
    add = "+",
    change = "|",
    delete = "-",
    topdelete = "‾",
    changedelete = "~",
    untracked = "┆",
  },
  ui = {
    selection_caret = " ",
    Telescope = " ",
  }
}

---Get a specific icon set.
---@param category "kind"|"type"|"ui"|"documents"|"git"|"diagnostics"|"cmp"
---@param add_space? boolean @Add trailing space after the icon.
function icons.get(category, add_space)
  if add_space then
    return setmetatable({}, {
      __index = function(_, key)
        return data[category][key] .. " "
      end,
    })
  else
    return data[category]
  end
end

return icons
