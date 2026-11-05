-- lua/config/plugins/lsp.lua
-- Ported from lua/plugins/lsp.lua: lspsaga, blink.cmp, colorful-menu,
-- tiny-inline-diagnostic, mason (nvim-lspconfig needs no setup).
-- Loaded from config/plugins.lua. Server enabling lives in config/lsp.lua.

-- ------------------------------------------------------------------ mason
require("mason").setup({})

-- ----------------------------------------------------------------- lspsaga
do
  local icons = require("config.icons")

  require("lspsaga").setup({
    symbol_in_winbar = { enable = false },
    show_code_action = true,
    debug = false,
    -- for disable phpactor code_action
    lightbulb = { enable = false },
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
  vim.keymap.set("n", "<leader>k", "<CMD>Lspsaga diagnostic_jump_prev<CR>", opt)
  vim.keymap.set("n", "<leader>ca", "<CMD>Lspsaga code_action<CR>", opt)
end

-- ------------------------------------------------------------ colorful-menu
require("colorful-menu").setup({
  ls = {
    lua_ls = { arguments_hl = "@comment" },
    gopls = {
      align_type_to_right = true,
      add_colon_before_type = false,
    },
    ts_ls = { extra_info_hl = "@comment" },
    vtsls = { extra_info_hl = "@comment" },
    ["rust-analyzer"] = {
      extra_info_hl = "@comment",
      align_type_to_right = true,
    },
    clangd = {
      extra_info_hl = "@comment",
      align_type_to_right = true,
      import_dot_hl = "@comment",
    },
    zls = { align_type_to_right = true },
    roslyn = { extra_info_hl = "@comment" },
    basedpyright = { extra_info_hl = "@comment" },

    fallback = true,
  },
  fallback_highlight = "@variable",
  max_width = 60,
})

-- ---------------------------------------------------------------- blink.cmp
require("blink.cmp").setup({
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
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "markdown" },
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
      border = "rounded",
      winblend = 15,
      draw = {
        -- label and label_description are already combined in `label`
        -- by colorful-menu.nvim.
        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
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
})

-- ------------------------------------------------- tiny-inline-diagnostic
-- Original spec loaded this on `LspAttach` (after config/lsp.lua had set
-- virtual_text = true), so it could turn virtual_text back off. Keep that
-- ordering: do the setup on the first LspAttach, not at startup.
vim.api.nvim_create_autocmd("LspAttach", {
  once = true,
  group = vim.api.nvim_create_augroup("tiny-inline-diagnostic-setup", { clear = true }),
  callback = function()
    require("tiny-inline-diagnostic").setup()
    vim.diagnostic.config({ virtual_text = false })
  end,
})
