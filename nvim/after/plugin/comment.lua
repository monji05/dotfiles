local status, comment = pcall(require, 'Comment')

if (not status) then return end

comment.setup({
  toggler = {
    line = '<C-u>',
    block = '<C-y>'
  }
})
