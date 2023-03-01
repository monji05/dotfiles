local status, surround = pcall(require, 'nvim-surround')

if (not status) then
  print('not found nvim-srurround!')
  return
end

surround.setup()
