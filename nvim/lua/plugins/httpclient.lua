return {
  -- Requires Neovim 0.10.0+ and cURL.
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>Rs", desc = "Send request" },
    { "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
  },
  ft = { "http", "rest" },
  opts = {
    -- your configuration comes here
    global_keymaps = false,
  },
}
