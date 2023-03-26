return {
  "svrana/neosolarized.nvim",
  dependencies = { "tjdevries/colorbuddy.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local n = require("neosolarized").setup({
      comment_italics = false,
    })

    -- n.Color.new("black", "#000000")
    -- n.Group.new("CursorLine", n.colors.none, n.colors.base03, n.styles.NONE, n.colors.base1)
    -- n.Group.new("CursorLineNr", n.colors.yellow, n.colors.black, n.styles.NONE, n.colors.base1)
    --
    -- local cError = n.groups.Error.fg
    -- local cInfo = n.groups.Information.fg
    -- local cWarn = n.groups.Warning.fg
    -- local cHint = n.groups.Hint.fg
    --
    -- n.Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), n.styles.NONE)
    -- n.Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), n.styles.NONE)
    -- n.Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), n.styles.NONE)
    -- n.Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), n.styles.NONE)
    -- n.Group.new("DiagnosticUnderlineError", n.colors.none, n.colors.none, n.styles.undercurl, cError)
    -- n.Group.new("DiagnosticUnderlineWarn", n.colors.none, n.colors.none, n.styles.undercurl, cWarn)
    -- n.Group.new("DiagnosticUnderlineInfo", n.colors.none, n.colors.none, n.styles.undercurl, cInfo)
    -- n.Group.new("DiagnosticUnderlineHint", n.colors.none, n.colors.none, n.styles.undercurl, cHint)
    --
    -- n.Group.new("HoverBorder", n.colors.yellow, n.colors.none, n.styles.NONE)
  end,
}
