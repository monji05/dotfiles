return {
  "echasnovski/mini.surround",
  version = "*",
  event = "BufRead",
  require("mini.surround").setup({
    mappings = {
      highlight = "sH",
    },
  }),
}
