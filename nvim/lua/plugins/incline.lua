return {
  {
    "b0o/incline.nvim",
    config = function()
      -- local colors = require("iceberg_palette").colors
      local colors = require("solarized-osaka.colors").setup()
      local devicons = require("nvim-web-devicons")

      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.orange500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        hide = {
          cursorline = true,
        },
        window = {
          placement = {
            horizontal = "center",
            vertical = "top",
          },
          margin = {
            vertical = 0,
            horizontal = 0,
          },
        },

        render = function(props)
          local filename = vim.fn.expand("%:.")
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local separator = { "┊ ", guifg = colors.blue }

          local is_modified = {}
          if vim.bo[props.buf].modified then
            table.insert(is_modified, { " ", guifg = colors.green300 })
          end
          return {
            -- { show_git_branch() },
            -- { get_diagnostic_label() },
            -- { get_git_diff() },
            { is_modified },
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
            { filename, gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
          }
        end,
      })
    end,
  },
}
