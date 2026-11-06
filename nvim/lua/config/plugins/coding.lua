require("Comment").setup({
  toggler = {
    line = "<leader>u",
    block = "gc",
  },
})

require("ultimate-autopair").setup({
  bs = { -- *ultimate-autopair-map-backspace-config*
    single_delete = true,
    -- <!--|--> > bs > <!-|
  },
})

-- change html tag command is srtt"
-- Use `''` (empty string) to disable a mapping.
require("mini.surround").setup({
  mappings = {
    add = "sa", -- Add surrounding in Normal and Visual modes
    delete = "sd", -- Delete surrounding
    find = "sf", -- Find surrounding (to the right)
    find_left = "sF", -- Find surrounding (to the left)
    highlight = "sh", -- Highlight surrounding
    replace = "sr", -- Replace surrounding

    suffix_last = "l", -- Suffix to search with "prev" method
    suffix_next = "n", -- Suffix to search with "next" method
  },
})

require("conform").setup({
  formatters_by_ft = {
    json = { "fixjson", "jq" },
    php = { "phpcbf" },
    javascript = { "biome" }, -- faster 35x than prettier
    typescript = { "biome" },
    go = { "gofumpt" },
    lua = { "stylua" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("conform-format-on-save", { clear = true }),
  callback = function(args)
    require("conform").format({ bufnr = args.buf, timeout_ms = 500, lsp_format = "fallback" })
  end,
})
