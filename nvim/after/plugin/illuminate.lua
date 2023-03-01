local status, illuminate = pcall(require, 'illuminate')
if (not status) then
  print('illuminate not found')
  return
end

illuminate.configure()
