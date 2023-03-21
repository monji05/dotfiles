return {
  'windwp/nvim-ts-autotag',
  event = 'InsertEnter',
  config = function()
    local status, autotag = pcall(require, 'nvim-ts-autotag')

    if (not status) then return end

    autotag.setup({})
  end
}
