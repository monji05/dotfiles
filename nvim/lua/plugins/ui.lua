return {
  -- {
  --   "mfussenegger/nvim-dap",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "rcarriga/nvim-dap-ui",
  --     "theHamsta/nvim-dap-virtual-text",
  --     "folke/neodev.nvim",
  --   },
  --   keys = {
  --     "<F5>",
  --     "<F6>",
  --     "<F10>",
  --     "<F12>",
  --     "<leader>db",
  --     "<leader>dr",
  --     "<leader>dl",
  --     "<leader>tu",
  --   },
  --   config = function()
  --     local dap = require("dap")
  --     dap.adapters.php = {
  --       type = "executable",
  --       command = "node",
  --       args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
  --     }
  --
  --     dap.configurations.php = {
  --       {
  --         name = "OfferBox v1",
  --         type = "php",
  --         request = "launch",
  --         port = 9000,
  --         pathMappings = {
  --           ["/var/www/offerbox"] = "${workspaceFolder}",
  --         },
  --       },
  --       {
  --         name = "OfferBox v2",
  --         type = "php",
  --         request = "launch",
  --         port = 9000,
  --         pathMappings = {
  --           ["/var/www/offerbox/offerbox-v2"] = "${workspaceFolder}/offerbox-v2",
  --         },
  --       },
  --     }
  --
  --     vim.api.nvim_set_keymap("n", "<F5>", ":DapContinue<CR>", { silent = true })
  --     vim.api.nvim_set_keymap("n", "<F6>", ":DapStepInto<CR>", { silent = true })
  --     vim.api.nvim_set_keymap("n", "<F10>", ":DapStepOver<CR>", { silent = true })
  --     vim.api.nvim_set_keymap("n", "<F12>", ":DapStepOut<CR>", { silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>dr", ':lua require("dap").repl.open()<CR>', { silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>dl", ':lua require("dap").run_last()<CR>', { silent = true })
  --   end,
  -- },
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   event = "VeryLazy",
  --   keys = {
  --     "<F5>",
  --     "<F6>",
  --     "<F10>",
  --     "<F12>",
  --     "<leader>db",
  --     "<leader>dr",
  --     "<leader>dl",
  --     "<leader>tu",
  --   },
  --   config = function()
  --     ---@diagnostic disable-next-line: missing-fields
  --     require("dapui").setup({
  --       ---@diagnostic disable-next-line: missing-fields
  --       icons = { expanded = "", collapsed = "" },
  --       layouts = {
  --         {
  --           elements = {
  --             { id = "watches", size = 0.20 },
  --             { id = "stacks", size = 0.20 },
  --             { id = "breakpoints", size = 0.20 },
  --             { id = "scopes", size = 0.40 },
  --           },
  --           size = 50,
  --           position = "right",
  --         },
  --         {
  --           elements = {
  --             "repl",
  --             "console",
  --           },
  --           size = 0.20,
  --           position = "bottom",
  --         },
  --       },
  --     })
  --     vim.api.nvim_set_keymap("n", "<leader>tu", "<Cmd>lua require('dapui').toggle()<CR>", { silent = true })
  --   end,
  -- },
  {
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        -- https://github.com/TheZoraiz/ascii-image-converter
        -- ascii-image-converter kogoro.png -bd 60,20
        header = {
          [[                                                ]],
          [[⠀                        ⣠⣤⣤⣄⡀⠀                 ]],
          [[                        ⢰⣿⣿⣿⣿⡏⠀                 ]],
          [[⠀⠀⠀⠀⠀   ⣀⣤⣴⣖⠺⣦⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀    ⣼⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⡀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀     ⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢟⠁⠀⠀⠀⣀⠸⣯⠉⠉⠙⠿⡃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[     ⠰⣿⣯⠎⠙⢿⣿⣿⠿⣿⣿⣿⣿⡷⠀⠀⣾⠻⣄⣿⣤⣴⣶⢠⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[   ⢀⣤⣾⡛⠉⠀⠀⠀⠀⠀⠀⢸⠿⠋⠁⠀⠀⠀⣿⠀⢸⣿⣿⣿⣿⣿⣿⠷⠀⠀⠀⠀⠀⠠⣆⣸⣷⣦⡀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⣠⣚⠉⠉⠛⠦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡀⠈⢿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀]],
          [[⢠⡾⠛⠻⠿⢶⡤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⡄⢸⣿⣿⣿⣆⠀⢀⣠⣴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣾⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢙⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⢸⣿⣿⣿⠋⠀⠀⠀⡅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠀⣿⣿⣿⣿⣷⣶⣶⡛⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⢰⣿⣿⣿⡟⢿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠀⠀⠀⢻⣿⣿⣿⡌⠻⠿⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ⢀⠀⠀⠹⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ⠀⢸⣇⠀⠀⠸⠟⢉⣳⢀⡺⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀      ⢸⣿⣆⠀⠀⠀⠙⢿⡿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[                                                ]],
        },
        center = {
          { action = [[lua require("telescope.builtin").find_files()]], desc = " Find file", icon = " ", key = "f" },
          { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
          {
            action = [[lua require("telescope.builtin").oldfiles()]],
            desc = " Recent files",
            icon = " ",
            key = "r",
          },
          { action = [[lua require("telescope.builtin").live_grep()]], desc = " Find text", icon = " ", key = "g" },
          { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
          { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
          { action = "qa", desc = " Quit", icon = " ", key = "q" },
        },
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    ft = { "css", "lua", "tsx", "jsx", "js" },
    event = { "BufReadPre", "BufNewFile" },
    ft = {
      "css",
      "jsx",
      "tsx",
    },
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
    "MeanderingProgrammer/markdown.nvim",
    ft = "markdown",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("render-markdown").setup({
        highlights = {
          heading = {
            -- Background of heading line
            backgrounds = { "NONE" },
            -- Foreground of heading character only
            foregrounds = {
              "diffAdded",
              "diffChanged",
              "diffremoved",
            },
          },
          -- Horizontal break
          dash = "CursorLineNr",
          -- Code blocks
          code = "ColorColumn",
          -- Bullet points in list
          bullet = "Number",
          checkbox = {
            -- Unchecked checkboxes
            unchecked = "@markup.list.unchecked",
            -- Checked checkboxes
            checked = "@markup.heading",
          },
          table = {
            -- Header of a markdown table
            head = "@markup.heading",
            -- Non header rows in a markdown table
            row = "Normal",
          },
          -- LaTeX blocks
          latex = "@markup.math",
          -- Quote character in a block quote
          quote = "@markup.quote",
        },
      })
    end,
  },
  -- {
  --   "romgrk/barbar.nvim",
  --   event = "InsertLeave",
  --   keys = {
  --     { "<Tab>", "<Cmd>BufferNext<CR>" },
  --     { "<S-Tab>", "<Cmd>BufferPrevious<CR>" },
  --     { "<Leader><left>", "<Cmd>BufferMovePrevious<CR>" },
  --     { "<Leader><right>", "<Cmd>BufferMoveNext<CR>" },
  --     { "<Leader>P", "<Cmd>BufferPin<CR>" },
  --     { "<C-x>", "<Cmd>BufferClose<CR>" },
  --     { "<S-x>", "<Cmd>BufferRestore<CR>" },
  --     { "<Leader>p", "<Cmd>BufferPick<CR>" },
  --     { "<Leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>" },
  --     { "<Leader>bd", "<Cmd>BufferOrderByDirectory<CR>" },
  --     { "<Leader>bl", "<Cmd>BufferOrderByLanguage<CR>" },
  --     { "<Leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>" },
  --   },
  --   config = function()
  --     local icons = require("lazyvim.config").icons
  --     local barbar = require("barbar")
  --     local opts = {
  --       -- Enable highlighting visible buffers
  --       highlight_visible = false,
  --       -- Disable highlighting alternate buffers
  --       highlight_alternate = false,
  --       icons = {
  --         -- modified = {
  --         --   button = "[+]",
  --         -- },
  --         pinned = { button = "", filename = true },
  --         button = "",
  --         -- Configure the base icons on the bufferline.
  --         -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
  --         buffer_index = true,
  --         buffer_number = false,
  --         -- Enables / disables diagnostic symbols
  --         diagnostics = {
  --           [vim.diagnostic.severity.ERROR] = { enabled = false, icon = icons.diagnostics.error },
  --           [vim.diagnostic.severity.WARN] = { enabled = false, icon = icons.diagnostics.warn },
  --           [vim.diagnostic.severity.INFO] = { enabled = false, icon = icons.diagnostics.info },
  --           [vim.diagnostic.severity.HINT] = { enabled = false, icon = icons.diagnostics.hint },
  --         },
  --         gitsigns = {
  --           added = { enabled = true, icon = icons.git.added },
  --           changed = { enabled = true, icon = icons.git.modified },
  --           deleted = { enabled = true, icon = icons.git.deleted },
  --         },
  --       },
  --     }
  --
  --     -- vim.api.nvim_command([[highlight BufferCurrent  guifg=#002d38 guibg=#d33682]])
  --     vim.api.nvim_command([[highlight BufferCurrent  guifg=#dadada]])
  --     vim.api.nvim_command([[highlight BufferCurrentHint  guifg=#2aa198]])
  --     vim.api.nvim_command([[highlight BufferCurrentADDED  guifg=#719e07]])
  --     vim.api.nvim_command([[highlight BufferCurrentCHANGED  guifg=#b58900]])
  --     vim.api.nvim_command([[highlight BufferCurrentDELETED guifg=#b2555b]])
  --     vim.api.nvim_command([[highlight BufferCurrentSign  guifg=#719e07]])
  --     vim.api.nvim_command([[highlight BufferInactive guibg=#002b36]])
  --     vim.api.nvim_command([[highlight BufferInactiveMod guifg=#6d72c5  guibg=#002b36]])
  --     vim.api.nvim_command([[highlight BufferInactiveADDED guifg=#6d72c5 guibg=#002b36]])
  --     vim.api.nvim_command([[highlight BufferInactiveCHANGED guifg=#6d72c5 guibg=#002b36]])
  --     vim.api.nvim_command([[highlight BufferInactiveDELETED guifg=#6d72c5 guibg=#002b36]])
  --     vim.api.nvim_command([[highlight BufferInactiveSign guibg=#002b36]])
  --     vim.api.nvim_command([[highlight BufferInactiveERROR guibg=#002b36]])
  --     vim.api.nvim_command([[highlight BufferInactiveWARN guibg=#002b36]])
  --     vim.api.nvim_command([[highlight BufferInactiveINFO guibg=#002b36]])
  --     vim.api.nvim_command([[highlight BufferInactiveHINT guibg=#002b36]])
  --     vim.api.nvim_command([[highlight BufferInactiveIndex guibg=#002b36]])
  --
  --     barbar.setup(opts)
  --   end,
  -- },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local miniIcons = require("mini.icons")
          local icon = miniIcons.get("file", filename)
          local devicons = require("nvim-web-devicons")
          local _icon, color = devicons.get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename, gui = "bold,italic" } }
        end,
      })
    end,
  },
  -- icons
  {
    "echasnovski/mini.icons",
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
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup({
        hl_priority = 10000,
      })
      -- solarized-osaka
      vim.api.nvim_command([[highlight Hlargs guifg=#c94c16]])
      -- everforest
      -- vim.api.nvim_command([[highlight Hlargs guifg=#dbbc7f]])
    end,
  },
}
