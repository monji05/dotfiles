return {
  "svrana/neosolarized.nvim",
  dependencies = { "tjdevries/colorbuddy.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local n = require("neosolarized").setup({
      comment_italics = false,
      -- background_set = true,
    })

    -- basic color
    -- Color.new("base03", "#002b36")
    -- Color.new("base02", "#073642")
    -- Color.new("base01", "#586e75")
    -- Color.new("base00", "#657b83")
    -- Color.new("base0", "#839496")
    -- Color.new("base1", "#93a1a1")
    -- Color.new("base2", "#eee8d5")
    -- Color.new("base3", "#fdf6e3")
    -- Color.new("yellow", "#b58900")
    -- Color.new("orange", "#cb4b16")
    -- Color.new("red", "#dc322f")
    -- Color.new("magenta", "#d33682")
    -- Color.new("violet", "#6c71c4")
    -- Color.new("blue", "#268bd2")
    -- Color.new("cyan", "#2aa198")
    -- Color.new("green", "#719e07")

    n.Color.new("black", "#000000")
    n.Group.new("CursorLine", n.colors.none, n.colors.base03, n.styles.NONE, n.colors.base1)
    n.Group.new("CursorLineNr", n.colors.yellow, n.colors.black, n.styles.NONE, n.colors.base1)

    local cError = n.groups.Error.fg
    local cInfo = n.groups.Information.fg
    local cWarn = n.groups.Warning.fg
    local cHint = n.groups.Hint.fg

    n.Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), n.styles.NONE)
    n.Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), n.styles.NONE)
    n.Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), n.styles.NONE)
    n.Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), n.styles.NONE)
    n.Group.new("DiagnosticUnderlineError", n.colors.none, n.colors.none, n.styles.undercurl, cError)
    n.Group.new("DiagnosticUnderlineWarn", n.colors.none, n.colors.none, n.styles.undercurl, cWarn)
    n.Group.new("DiagnosticUnderlineInfo", n.colors.none, n.colors.none, n.styles.undercurl, cInfo)
    n.Group.new("DiagnosticUnderlineHint", n.colors.none, n.colors.none, n.styles.undercurl, cHint)
    n.Group.new("HoverBorder", n.colors.yellow, n.colors.none, n.styles.NONE)

    n.Color.new("myGitSingsAddBg", "#4F6E04")
    n.Color.new("myGitSingsChangeBg", "#7E5F00")
    n.Color.new("myGitSingsDeleteBg", "#9A2320")

    -- diff color on LineNumber
    n.Group.new("GitSignsAddLn", n.colors.none, n.colors.myGitSingsAddBg, n.styles.NONE)
    n.Group.new("GitSignsAddNr", n.colors.none, n.colors.myGitSingsAddBg, n.styles.NONE)
    n.Group.new("GitSignsChangeLn", n.colors.none, n.colors.myGitSingsChangeBg, n.styles.NONE)
    n.Group.new("GitSignsChangeNr", n.colors.none, n.colors.myGitSingsChangeBg, n.styles.NONE)
    n.Group.new("GitSignsDeleteLn", n.colors.none, n.colors.myGitSingsDeleteBg, n.styles.NONE)
    n.Group.new("GitSignsDeleteNr", n.colors.none, n.colors.myGitSingsDeleteBg, n.styles.NONE)

    -- for diffview
    n.Group.new("DiffAdd", n.colors.none, n.colors.base02, n.styles.NONE)
    n.Group.new("DiffChange", n.colors.none, n.colors.base02, n.styles.NONE)
    n.Group.new("DiffDelete", n.colors.red, n.colors.base02, n.styles.NONE)
    n.Group.new("DiffText", n.colors.black, n.colors.yellow, n.styles.NONE)
  end,
}
