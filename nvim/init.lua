require('ft')
require('options')
require('base')
require('highlights')
require('maps')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.api.nvim_command [[
  syntax off
  filetype plugin indent off
  filetype off
]]

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require('lazy').setup("plugins", {
  change_detection = {
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
})

local has = function(x)
  return vim.fn.has(x) == 1
end
local is_mac = has 'macunix'

if is_mac then
  require('macos')
elseif is_mac == 0 then
  require('windows')
end
