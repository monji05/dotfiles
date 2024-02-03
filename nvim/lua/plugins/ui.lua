return {
  {
    "romgrk/barbar.nvim",
    event = "InsertLeave",
    keys = {
      { "<Tab>", "<Cmd>BufferNext<CR>" },
      { "<S-Tab>", "<Cmd>BufferPrevious<CR>" },
      { "<Leader><left>", "<Cmd>BufferMovePrevious<CR>" },
      { "<Leader><right>", "<Cmd>BufferMoveNext<CR>" },
      { "<Leader>P", "<Cmd>BufferPin<CR>" },
      { "<Leader>x", "<Cmd>BufferClose<CR>" },
      { "<S-x>", "<Cmd>BufferRestore<CR>" },
      { "<Leader>p", "<Cmd>BufferPick<CR>" },
      { "<Leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>" },
      { "<Leader>bd", "<Cmd>BufferOrderByDirectory<CR>" },
      { "<Leader>bl", "<Cmd>BufferOrderByLanguage<CR>" },
      { "<Leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>" },
    },
    config = function()
      local icons = require("lazyvim.config").icons
      local my_icons = require("config.icons")
      local barbar = require("barbar")
      local opts = {
        -- Enable highlighting visible buffers
        highlight_visible = true,
        -- Disable highlighting alternate buffers
        highlight_alternate = false,
        icons = {
          pinned = { button = "", filename = true },
          button = "",
          -- Configure the base icons on the bufferline.
          -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
          buffer_index = false,
          buffer_number = false,
          -- Enables / disables diagnostic symbols
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = true, icon = icons.diagnostics.error },
            [vim.diagnostic.severity.WARN] = { enabled = true, icon = icons.diagnostics.warn },
            [vim.diagnostic.severity.INFO] = { enabled = true, icon = icons.diagnostics.info },
            [vim.diagnostic.severity.HINT] = { enabled = true, icon = icons.diagnostics.hint },
          },
          gitsigns = {
            added = { enabled = true, icon = my_icons.git.added },
            changed = { enabled = true, icon = my_icons.git.modified },
            deleted = { enabled = true, icon = my_icons.git.deleted },
          },
        },
      }
      -- highlight
      vim.api.nvim_command([[highlight BufferCurrent  guifg=#dadada]])
      vim.api.nvim_command([[highlight BufferCurrentHint  guifg=#2aa198]])
      vim.api.nvim_command([[highlight BufferCurrentADDED  guifg=#719e07]])
      vim.api.nvim_command([[highlight BufferCurrentCHANGED  guifg=#b58900]])
      vim.api.nvim_command([[highlight BufferCurrentDELETED guifg=#b2555b]])
      vim.api.nvim_command([[highlight BufferCurrentSign  guifg=#719e07]])
      vim.api.nvim_command([[highlight BufferInactive guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveMod  guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveADDED guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveCHANGED guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveDELETED guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveSign guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveERROR guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveWARN guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveINFO guibg=#002b36]])
      vim.api.nvim_command([[highlight BufferInactiveHINT guibg=#002b36]])
      barbar.setup(opts)
    end,
  },
  {
    "lewis6991/hover.nvim",
    keys = {
      "<Leader>K",
      "<Leader>gK",
    },
    config = function()
      require("hover").setup({
        init = function()
          -- Require providers
          -- require("hover.providers.lsp")
          -- require("hover.providers.gh")
          -- require("hover.providers.gh_user")
          -- require('hover.providers.jira')
          -- require("hover.providers.man")
          require("hover.providers.dictionary")
        end,
        preview_opts = {
          border = nil,
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
      })

      -- Setup keymaps
      vim.keymap.set("n", "<Leader>K", require("hover").hover, { desc = "hover.nvim" })
      vim.keymap.set("n", "<Leader>gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
    end,
  },
  {
    "folke/noice.nvim",
    event = "BufEnter",
    module = "noice",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {
      cmdline = {
        format = {
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        },
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        center = {
          { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
          { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
          { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
          { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
          {
            action = [[lua require("lazyvim.util").telescope.config_files()()]],
            desc = " Config",
            icon = " ",
            key = "c",
          },
          { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
          { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
          { action = "qa", desc = " Quit", icon = " ", key = "q" },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    -- config = function()
    --   require("lualine").setup({
    --     -- theme = "solarized-osaka",
    --     sections = {
    --       lualine_b = {
    --         "branch",
    --       },
    --       lualine_c = {
    --         {
    --           "filename",
    --           file_status = true,
    --           path = 1,
    --         },
    --       },
    --     },
    --   })
    -- end,
    config = function()
      local lualine = require("lualine")
      local lazy_status = require("lazy.status") -- to configure lazy pending updates count

      local colors = {
        blue = "#65D1FF",
        green = "#3EFFDC",
        violet = "#FF61EF",
        yellow = "#FFDA7B",
        red = "#FF4A4A",
        fg = "#c3ccdc",
        bg = "#112638",
        inactive_bg = "#2c3043",
      }

      local my_lualine_theme = {
        normal = {
          a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        insert = {
          a = { bg = colors.green, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        visual = {
          a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        command = {
          a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        replace = {
          a = { bg = colors.red, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        inactive = {
          a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
          b = { bg = colors.inactive_bg, fg = colors.semilightgray },
          c = { bg = colors.inactive_bg, fg = colors.semilightgray },
        },
      }

      local lint_progress = function()
        local linters = require("lint").get_running()
        if #linters == 0 then
          return "󰦕"
        end
        return "󱉶 " .. table.concat(linters, ", ")
      end

      -- configure lualine with modified theme
      lualine.setup({
        options = {
          theme = my_lualine_theme,
        },
        sections = {
          lualine_b = {
            "branch",
          },
          lualine_c = {
            {
              "filename",
              file_status = true,
              path = 1,
            },
            {
              lint_progress,
            },
          },
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
            },
            { "encoding" },
            { "fileformat" },
            { "filetype" },
          },
        },
      })
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
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
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  },
  {
    "TobinPalmer/rayso.nvim",
    cmd = { "Rayso" },
    config = function()
      require("rayso").setup({})
    end,
  },
}
