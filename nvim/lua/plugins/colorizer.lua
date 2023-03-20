return {
  'NvChad/nvim-colorizer.lua',
  event = 'BufRead',
  lazy = true,
  config = function()
    require("colorizer").setup {
      filetypes = { '*' },
      user_default_options = {
        tailwind = true,
      }
    }
  end
}
