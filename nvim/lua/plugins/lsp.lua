return {
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      local icons = require("lazyvim.config").icons

      require("lspsaga").setup({
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
        infor_sign = icons.info,
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
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    opts = {
      servers = {
        lua_ls = {},
        intelephense = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "folke/snacks.nvim",
    },

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
      },
      completion = {
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
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
    "xzbdmw/colorful-menu.nvim",
    config = function()
      require("colorful-menu").setup({
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
      })
    end,
  },
}
