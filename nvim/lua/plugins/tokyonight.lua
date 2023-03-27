return {
  "folke/tokyonight.nvim",
  opts = {
    style = "storm",
    transparent = true,
    styles = {
      sidebar = "transparent",
      floats = "transparent",
    },
    on_colors = function(colors)
      -- bg_dark = "#1e2030",
      -- bg = "#222436",
      colors.black = "#000000"
      colors.comment = "#828590"
      colors.gitSigns = {
        add = "#719e07",
        change = colors.orange,
        delete = "#dc322f",
      }
    end,
    on_highlights = function(highlight, colors)
      highlight.LineNr = {
        fg = colors.dark5,
      }
      highlight.CursorLineNr = {
        fg = colors.orange,
        bg = colors.black,
      }
      highlight.Comment = {
        fg = colors.comment,
      }
      highlight.GitSignAdd = {
        fg = colors.gitSigns.add,
      }
      highlight.GitSignChange = {
        fg = colors.orange,
      }
    end,
  },
}