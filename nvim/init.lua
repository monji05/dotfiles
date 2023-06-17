vim.loader.enable()
_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath("cache") .. "/luacache_chunks",
  },
  modpaths = {
    enable = true,
    path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
  },
}
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/impatient")
local ok, impatient = pcall(require, "impatient")
if ok then
  impatient.enable_profile()
else
  print("impatient.nvim can't load")
end

require("config.options")
require("config.keymaps")
require("config.utils")

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has("macunix")
if is_mac then
  require("config/macos")
elseif is_mac == 0 then
  require("config/windows")
end
