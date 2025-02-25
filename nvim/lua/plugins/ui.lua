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
    "NvChad/nvim-colorizer.lua",
    ft = { "css", "lua", "tsx", "jsx", "js" },
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
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormalNC = { guibg = colors.base04, guifg = colors.base00 },
            InclineNormal = { guibg = colors.magenta900, guifg = colors.violet500 },
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

          local function get_git_diff()
            local icons = { removed = " ", changed = " ", added = " " }
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

          local miniIcons = require("mini.icons")
          local icon = miniIcons.get("file", filename)
          local devicons = require("nvim-web-devicons")
          local _icon, color = devicons.get_icon_color(filename)
          return {
            { get_git_diff() },
            { get_diagnostic_label() },
            { icon, guifg = color },
            { " " },
            { filename, gui = "bold,italic" },
          }
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
      -- solarized-osaka
      require("hlargs").setup({})
      -- solarized-osaka
      vim.api.nvim_command([[highlight Hlargs guifg=#c94c16]])
    end,
  },
}
