return {
  "hrsh7th/nvim-cmp", -- Completion
  dependencies = {
    { "hrsh7th/cmp-buffer",                     event = "InsertEnter" },
    { "roobert/tailwindcss-colorizer-cmp.nvim", event = "InsertEnter" },
    { "L3MON4D3/LuaSnip",                       event = "InsertEnter" },
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
          local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 55 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"
          return kind
        end,
      },
      window = {
        completion = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = -3,
          side_padding = 0,
        },
      },
    })

    vim.api.nvim_command([[
      set completeopt=menuone,noinsert,noselect
      highlight! default link CmpItemKind CmpItemMenuDefault
    ]])
  end,
}
