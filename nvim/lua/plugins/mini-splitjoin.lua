return {
  "echasnovski/mini.splitjoin",
  event = "BufRead",
  cmd = "Gs",
  require('mini.splitjoin').setup({
    mappings = {
      toggle = "gs",
    }
  })
}
