local icons = {}

local data = {
  kind = {
    Array = "󰅪 ",
    Boolean = "◩ ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = "󱌣 ",
    Enum = "",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Function = "󰊕 ",
    Folder = " ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = " ",
    Module = "󰚥 ",
    Namespace = "󰕣 ",
    Null = "󰟢 ",
    Number = "󰎠 ",
    Object = "󰅩 ",
    Operator = " ",
    Package = "󰕣 ",
    Property = " ",
    Reference = "",
    Snippet = "",
    String = " ",
    Struct = "󰌗 ",
    Text = "",
    TypeParameter = "",
    Unit = "",
    Value = " ",
    Variable = " ",
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
  },
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
