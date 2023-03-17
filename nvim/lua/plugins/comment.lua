return {
  'numToStr/Comment.nvim',
  keys = { '<C-u>', '<C-y>' },
  lazy = true,
  config = function()
    local status, comment = pcall(require, 'Comment')

    if (not status) then return end

    comment.setup({
      toggler = {
        line = '<C-u>',
        block = '<C-y>'
      }
    })
  end
}
