return {
  {
    "nvimdev/lspsaga.nvim",
    event = "BufReadPre",
    config = function()
      local icons = require("lazyvim.config").icons

      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false,
        },
        show_code_action = true,
        debug = false,
        -- for disable phpactor code_action
        lightbulb = {
          enable = false,
        },
        use_saga_diagnostic_sign = true,
        -- diagnostic sign
        error_sign = icons.error,
        warn_sign = icons.warn,
        hint_sign = icons.hint,
        info_sign = icons.info,
        diagnostic_header_icon = icons.header,
        code_action_prompt = {
          enable = true,
          sign = true,
          sign_priority = 40,
          virtual_text = true,
        },
        finder_definition_icon = icons.finder_definition,
        finder_reference_icon = icons.finder_reference,
        max_preview_lines = 10,
        finder_action_keys = {
          open = "o",
          vsplit = "s",
          split = "i",
          quit = "q",
          scroll_down = "<C-f>",
          scroll_up = "<C-b>",
        },
        rename_action_keys = {
          quit = "<C-c>",
          exec = "<CR>",
        },
        definition_preview_icon = icons.preview,
        border_style = "single",
        rename_prompt_prefix = icons.rename_prompt_prefix,
        rename_output_qflist = {
          enable = true,
          auto_open_qflist = true,
        },
        server_filetype_map = {},
        diagnostic_prefix_format = "%d. ",
        diagnostic_message_format = "%m %c",
        highlight_prefix = false,
      })

      local opt = { silent = true, noremap = true }
      vim.keymap.set("n", "gd", "<CMD>Lspsaga goto_definition<CR>", opt)
      vim.keymap.set("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opt)
      vim.keymap.set("n", "gh", "<CMD>Lspsaga hover_doc<CR>", opt)
      vim.keymap.set("n", "gf", "<CMD>Lspsaga finder<Cr>", opt)
      vim.keymap.set("n", "<leader>j", "<CMD>Lspsaga diagnostic_jump_next<CR>", opt)
      vim.keymap.set("n", "<leader>ca", "<CMD>Lspsaga code_action<CR>", opt)
    end,
  },
  {
    "saghen/blink.cmp",
    event = { "InsertEnter" },

    version = "*",
    opts = {
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "markdown",
        },
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
          },
        },
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
      keymap = {
        preset = "default",
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<CR>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },

        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
      completion = {
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { "label", "label_description" }, { gap = 1, "kind_icon", "kind" } },
            components = {
              kind_icon = {
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                -- (optional) use highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- config = function()
    -- local lspconfig = require("lspconfig")
    -- require("mason-lspconfig").setup_handlers({
    --   ts_ls = function()
    --     lspconfig.tsserver.setup({
    --       on_attach = function(client, bufnr)
    --         client.server_capabilities.documentFormattingProvider = false
    --         client.server_capabilities.documentRangeFormattingProvider = false
    --       end,
    --     })
    --   end,
    -- })
    -- end,
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason" },
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "cspell",
        "markdownlint",
        "markdown-toc",
        -- "intelephense",
        "phpactor",
        "lua-language-server",
        "tailwindcss-language-server",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.phpactor.setup({
        -- Server-specific settings. See `:help lspconfig-setup`
        settings = {
          ["phpactor"] = {
            servers = {
              phpactor = {
                init_options = {
                  provideFormatter = false,
                  -- doc https://phpactor.readthedocs.io/en/master/lsp/vim.html
                  -- phpstan config
                  -- NOTE: phpactorのphpstanが動いていない
                  -- ["language_server_phpstan.enabled"] = true,
                  -- ["language_server_phpstan.bin"] = "%project_root%/offerbox-v2/vendor/bin/phpstan",
                  -- ["language_server_phpstan.level"] = 9,
                  -- ["language_server_phpstan.config"] = "./offerbox-v2/phpstan.neon.dist",
                  -- ["language_server_phpstan.mem_limit"] = "2G",

                  ["language_server.diagnostic_exclude_paths"] = {
                    "node_modules/**/*",
                    ".git/**/*",
                    "vendor/**/*",
                    "tests/**/*",
                  },
                },
              },
            },
          },
        },
      })
      lspconfig.lua_ls.setup({})
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      })
    end,
  },
  {
    "xzbdmw/colorful-menu.nvim",
    event = "InsertEnter",
    opts = {
      ls = {
        lua_ls = {
          arguments_hl = "@comment",
        },
        gopls = {
          align_type_to_right = true,
          add_colon_before_type = false,
        },
        ts_ls = {
          extra_info_hl = "@comment",
        },
        vtsls = {
          extra_info_hl = "@comment",
        },
        ["rust-analyzer"] = {
          extra_info_hl = "@comment",
          align_type_to_right = true,
        },
        clangd = {
          extra_info_hl = "@comment",
          align_type_to_right = true,
          import_dot_hl = "@comment",
        },
        zls = {
          align_type_to_right = true,
        },
        roslyn = {
          extra_info_hl = "@comment",
        },
        basedpyright = {
          extra_info_hl = "@comment",
        },

        fallback = true,
      },
      fallback_highlight = "@variable",
      max_width = 60,
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
}
