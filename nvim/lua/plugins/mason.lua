return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    {
      automatic_installation = true,
    },
  },
}
