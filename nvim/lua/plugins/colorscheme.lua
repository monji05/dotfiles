return {
  "craftzdog/solarized-osaka.nvim",
  lazy = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  opts = {
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
  },
}
