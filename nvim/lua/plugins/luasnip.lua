return {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
  config = function()
    local status, _ = pcall(require, 'luasnip')
    if (not status) then
      return
    end
  end
}
