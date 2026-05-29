return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
  },
  keys = {
    {
      ";s",
      desc = "restore session",
      function()
        require('persistence').load()
      end,
    }
  }
}

