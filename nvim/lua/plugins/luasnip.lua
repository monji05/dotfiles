return {
  'L3MON4D3/LuaSnip',
  ft = 'lua',
  lazy = true,
  config = function()
    local status, _ = pcall(require, 'luasnip')
    if (not status) then
      return
    end
  end
}
