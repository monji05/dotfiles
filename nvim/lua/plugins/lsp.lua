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
        highlight_prefix = true,
      })

      local opt = { silent = true, noremap = true }
      vim.keymap.set("n", "gd", "<CMD>Lspsaga goto_definition<CR>", opt)
      vim.keymap.set("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opt)
      vim.keymap.set("n", "gh", "<CMD>Lspsaga hover_doc<CR>", opt)
      vim.keymap.set("n", "gf", "<CMD>Lspsaga finder<Cr>", opt)
      vim.keymap.set("n", "<leader>j", "<CMD>Lspsaga diagnostic_jump_next<CR>", opt)
      vim.keymap.set("n", "<leader>k", "<CMD>Lspsaga diagnostic_jump_prev<CR>", opt)
      vim.keymap.set("n", "<leader>ca", "<CMD>Lspsaga code_action<CR>", opt)
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "mikavilpas/blink-ripgrep.nvim",
    },
    event = { "InsertEnter" },

    version = "*",
    opts = {
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      keymap = {
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
      },
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "markdown",
          "ripgrep",
        },
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
          },
          -- 👇🏻👇🏻 add the ripgrep provider config below
          ripgrep = {
            module = "blink-ripgrep",
            name = " Ripgrep",
            -- the options below are optional, some default values are shown
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              -- the minimum length of the current word to start searching
              -- (if the word is shorter than this, the search will not start)
              prefix_min_len = 3,

              -- Specifies how to find the root of the project where the ripgrep
              -- search will start from. Accepts the same options as the marker
              -- given to `:h vim.fs.root()` which offers many possibilities for
              -- configuration. If none can be found, defaults to Neovim's cwd.
              --
              -- Examples:
              -- - ".git" (default)
              -- - { ".git", "package.json", ".root" }
              project_root_marker = ".git",

              -- When a result is found for a file whose filetype does not have a
              -- treesitter parser installed, fall back to regex based highlighting
              -- that is bundled in Neovim.
              fallback_to_regex_highlighting = true,

              -- Keymaps to toggle features on/off. This can be used to alter
              -- the behavior of the plugin without restarting Neovim. Nothing
              -- is enabled by default. Requires folke/snacks.nvim.
              toggles = {
                -- The keymap to toggle the plugin on and off from blink
                -- completion results. Example: "<leader>tg" ("toggle grep")
                on_off = nil,

                -- The keymap to toggle debug mode on/off. Example: "<leader>td" ("toggle debug")
                debug = nil,
              },

              backend = {
                -- The backend to use for searching. Defaults to "ripgrep".
                -- Available options:
                -- - "ripgrep", always use ripgrep
                -- - "gitgrep", always use git grep
                -- - "gitgrep-or-ripgrep", use git grep if possible, otherwise
                --   use ripgrep
                use = "ripgrep",

                -- Whether to set up custom highlight-groups for the icons used
                -- in the completion items. Defaults to `true`, which means this
                -- is enabled.
                customize_icon_highlight = true,

                ripgrep = {
                  -- For many options, see `rg --help` for an exact description of
                  -- the values that ripgrep expects.

                  -- The number of lines to show around each match in the preview
                  -- (documentation) window. For example, 5 means to show 5 lines
                  -- before, then the match, and another 5 lines after the match.
                  context_size = 5,

                  -- The maximum file size of a file that ripgrep should include
                  -- in its search. Useful when your project contains large files
                  -- that might cause performance issues.
                  -- Examples:
                  -- "1024" (bytes by default), "200K", "1M", "1G", which will
                  -- exclude files larger than that size.
                  max_filesize = "1M",

                  -- Enable fallback to neovim cwd if project_root_marker is not
                  -- found. Default: `true`, which means to use the cwd.
                  project_root_fallback = true,

                  -- The casing to use for the search in a format that ripgrep
                  -- accepts. Defaults to "--ignore-case". See `rg --help` for
                  -- all the available options ripgrep supports, but you can try
                  -- "--case-sensitive" or "--smart-case".
                  search_casing = "--ignore-case",

                  -- (advanced) Any additional options you want to give to
                  -- ripgrep. See `rg -h` for a list of all available options.
                  -- Might be helpful in adjusting performance in specific
                  -- situations. If you have an idea for a default, please open
                  -- an issue!
                  --
                  -- Not everything will work (obviously).
                  additional_rg_options = {},

                  -- Absolute root paths where the rg command will not be
                  -- executed. Usually you want to exclude paths using gitignore
                  -- files or ripgrep specific ignore files, but this can be used
                  -- to only ignore the paths in blink-ripgrep.nvim, maintaining
                  -- the ability to use ripgrep for those paths on the command
                  -- line. If you need to find out where the searches are
                  -- executed, enable `debug` and look at `:messages`.
                  ignore_paths = {},

                  -- Any additional paths to search in, in addition to the
                  -- project root. This can be useful if you want to include
                  -- dictionary files (/usr/share/dict/words), framework
                  -- documentation, or any other reference material that is not
                  -- available within the project root.
                  additional_paths = {},
                },
              },

              -- Show debug information in `:messages` that can help in
              -- diagnosing issues with the plugin.
              debug = false,
            },
            -- (optional) customize how the results are displayed. Many options
            -- are available - make sure your lua LSP is set up so you get
            -- autocompletion help
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                -- example: append a description to easily distinguish rg results
                item.labelDetails = {
                  description = "(rg)",
                }
              end
              return items
            end,
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
  { "mason-org/mason.nvim", lazy = true, opts = {} },
  { "neovim/nvim-lspconfig", lazy = true },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup_handlers({
        intelephense = function()
          lspconfig.intelephense.setup({})
        end,
        lua_ls = function()
          lspconfig.lua_ls.setup({})
        end,
        ts_ls = function()
          lspconfig.ts_ls.setup({
            on_attach = function(client, bufnr)
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end,
          })
        end,
        pyright = function()
          lspconfig.pyright.setup({})
        end,
        efm = function()
          lspconfig.efm.setup({
            filetypes = { "php" },
            single_file_support = true,
            on_attach = function(client, bufnr)
              print("EFM attached to buffer: " .. bufnr)

              -- PHPファイルがアタッチされたらすぐにphpstanを実行
              local function run_phpstan()
                local filename = vim.api.nvim_buf_get_name(bufnr)

                -- PHPファイル以外は処理しない
                if not filename:match("%.php$") then
                  return
                end

                print("DEBUG: Starting phpstan run for " .. filename)
                -- フルパスから相対パスに変換
                local relative_path = filename:gsub("/Users/erikomishina/www/offerbox/public_html/offerbox%-v2/", "")
                print("Running phpstan for: " .. relative_path)

                local cmd = string.format(
                  "cd ~/www/offerbox/public_html/offerbox-v2 && docker compose exec -w /var/www/offerbox-v2 -T v2_php ./vendor/bin/phpstan analyse -l 9 -c phpstan.neon.dist --memory-limit=2G --no-progress --error-format=raw %s 2>/dev/null",
                  relative_path
                )

                vim.fn.jobstart(cmd, {
                  stdout_buffered = true,
                  stderr_buffered = true,
                  on_stdout = function(_, data)
                    local diagnostics = {}

                    print("PHPStan stdout data received:")
                    if data then
                      for i, line in ipairs(data) do
                        print(string.format("  [%d]: %q", i, line))
                        if line ~= "" and not line:match("^Note:") and not line:match("^$") then
                          -- PHPStanのraw形式をパース: file:line:message
                          local file, line_num, message = line:match("^([^:]+):(%d+):(.+)$")

                          if file and line_num and message then
                            print(string.format("Parsed - file: %s, line: %s, message: %s", file, line_num, message))
                            -- パスを正規化
                            local normalized_file = file:gsub(
                              "^/var/www/offerbox%-v2",
                              "/Users/erikomishina/www/offerbox/public_html/offerbox-v2"
                            )
                            print(string.format("Normalized file: %s", normalized_file))
                            print(string.format("Current filename: %s", filename))

                            -- 現在のファイルの診断のみ処理
                            if normalized_file == filename then
                              print("File matches! Adding diagnostic")
                              table.insert(diagnostics, {
                                lnum = tonumber(line_num) - 1, -- 0-based
                                col = 0,
                                severity = vim.diagnostic.severity.ERROR,
                                source = "phpstan",
                                message = "phpstan: " .. message:gsub("^%s*", ""), -- 先頭の空白を削除してプレフィックス追加
                              })
                            else
                              print("File does not match current buffer")
                            end
                          else
                            print("Could not parse line: " .. line)
                          end
                        end
                      end
                    end

                    print(string.format("Setting %d diagnostics", #diagnostics))
                    -- 診断を設定
                    vim.diagnostic.set(vim.api.nvim_create_namespace("phpstan"), bufnr, diagnostics)
                  end,
                  on_stderr = function(_, data)
                    -- Docker compose警告は無視
                    if data then
                      for _, line in ipairs(data) do
                        if line ~= "" and not line:match("MOCK.*variable") and not line:match("version.*obsolete") then
                          print("PHPStan Error: " .. line)
                        end
                      end
                    end
                  end,
                  on_exit = function(_, exit_code)
                    if exit_code == 0 then
                      -- エラーがない場合は診断をクリア
                      vim.diagnostic.set(vim.api.nvim_create_namespace("phpstan"), bufnr, {})
                      print("PHPStan: No issues found!")
                    end
                  end,
                })
              end

              -- 関数を実行
              run_phpstan()

              -- 保存時にも実行
              vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = bufnr,
                callback = run_phpstan,
              })
            end,
            init_options = { documentFormatting = true },
            settings = {
              languages = {
                php = {
                  lintCommand = "cd ~/www/offerbox/public_html/offerbox-v2 && docker compose exec -w /var/www/offerbox-v2 -T v2_php ./vendor/bin/phpstan analyse -l 9 -c phpstan.neon.dist --memory-limit=2G --no-progress --error-format=raw ${INPUT} | sed 's|/var/www/offerbox-v2|/Users/erikomishina/www/offerbox/public_html/offerbox-v2|g'",
                  lintStdin = false,
                  lintFormats = { "%f:%l:%m" },
                  lintIgnoreExitCode = true,
                  lintSource = "phpstan",
                },
              },
            },
          })
        end,
        -- NOTE: typosだとあまり検知してくれない
        -- inedx(index), hllo(hello) etc ので、cspellにする
      })

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
