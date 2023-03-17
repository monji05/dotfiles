return {
  'svrana/neosolarized.nvim',
  dependencies = { 'tjdevries/colorbuddy.nvim' },
  lazy = false,
  -- config
  config = function()
    local status, n = pcall(require, "neosolarized")
    if (not status) then return end

    n.setup({
      comment_italics = false,
    })

    local cb = require('colorbuddy.init')
    local Color = cb.Color
    local colors = cb.colors
    local Group = cb.Group
    local groups = cb.groups
    local styles = cb.styles

    Color.new('black', '#000000')
    Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
    Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
    Group.new('Visual', colors.none, colors.base03, styles.reverse)

    local cError = groups.Error.fg
    local cInfo = groups.Information.fg
    local cWarn = groups.Warning.fg
    local cHint = groups.Hint.fg

    Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
    Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
    Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
    Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
    Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
    Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
    Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
    Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

    Color.new("diffText", '#143228')
    Color.new('diffDelete', '#360b00')
    Color.new('diffAdd', '#143441')
    Group.new("DiffAdd", colors.none, colors.diffAdd, styles.NONE)
    Group.new("DiffDelete", colors.none, colors.diffDelete, styles.NONE)
    Group.new("DiffChange", colors.none, colors.base03, styles.NONE)
    Group.new('DiffText', colors.none, colors.diffText, styles.NONE)

    Group.new("HoverBorder", colors.yellow, colors.none, styles.NONE)
  end
}
