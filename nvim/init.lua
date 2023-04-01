require("config.options")
require("config.keymaps")
require("config.lazy")
-- nightfly
-- require("config.theme.myNightfly")

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has("macunix")
if is_mac then
  require("config/macos")
elseif is_mac == 0 then
  require("config/windows")
end

-- tokyonight
-- vim.api.nvim_command([[colorscheme tokyonight]])
