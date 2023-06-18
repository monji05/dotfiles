local icons = {}

local data = {
  kind = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },
  diagnostics = {
    error = "",
    warn = "",
    hint = "",
    info = "",
    header = "   ",
    preview = "  ",
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
}

---Get a specific icon set.
---@param category "kind"|"type"|"documents"|"git"|"diagnostics"|"cmp"
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
