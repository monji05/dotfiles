return {
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    ft = {
      "css",
      "jsx",
      "tsx",
      "lua",
    },
    opts = {
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true, -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
        virtualtext = "■",
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = false,
      },
    },
  },
  -- filename
  {
    "b0o/incline.nvim",
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guifg = colors.magenta500, guibg = colors.blue900 },
            InclineNormalNC = { guifg = colors.base00, guibg = colors.base03 },
          },
        },

        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local ft_icon, ft_color = devicons.get_icon_color(filename)

          local function get_git_diff()
            local icons = { removed = "-", changed = "~", added = "+" }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
              end
            end

            if #labels > 0 then
              table.insert(labels, { "┊ " })
            end
            return labels
          end

          local function get_diagnostic_label()
            local icons = { error = " ", warn = " ", info = " ", hint = " " }
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { "┊ " })
            end
            return label
          end

          local function show_git_branch()
            local label = {}
            local git_branch = (vim.b[props.buf].gitsigns_head or "")
            if git_branch ~= "" then
              table.insert(label, { "  " .. git_branch .. " ", guifg = colors.red300 })
            end

            if #label > 0 then
              table.insert(label, { "┊ " })
            end

            return label
          end

          local is_modified = {}
          if vim.bo[props.buf].modified then
            table.insert(is_modified, { " ", guifg = colors.yellow })
          end
          return {
            { show_git_branch() },
            { get_diagnostic_label() },
            { get_git_diff() },
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
            { filename, gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
            { is_modified },
          }
        end,
      })
    end,
  },
  -- icons
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {
      extension = {
        ["php"] = {
          glyph = "",
          hl = "MiniIconsPurple",
        },
        ["blade.php"] = {
          glyph = "󰫐",
          hl = "MiniIconsRed",
        },
        ["composer.lock"] = {
          glyph = "",
          hl = "MiniIconsRed",
        },
      },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
}
