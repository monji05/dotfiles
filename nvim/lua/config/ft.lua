local api = vim.api

local filetype_dict = {
  sh = "bash",
  py = "python",
  md = "markdown",
  lua = "lua",
  vim = "vim",
  fish = "fish",
  php = "php",
}

local filename_dict = {
  vifmrc = "vim",
}

local function ft_detect()
  -- ext = api.nvim_buf_get_name(0):gsub(".*/", '')

  local fileExt = vim.fn.expand("%:e")
  local fileName = vim.fn.expand("%:t")

  vim.bo.ft = fileExt ~= "" and filetype_dict[fileExt] or filename_dict[fileName]

  vim.defer_fn(function()
    pcall(api.nvim_command, "luafile ~/.config/nvim/ftplugin/" .. vim.bo.ft .. ".lua")
  end, 150)
end

ft_detect()

api.nvim_create_autocmd({ "BufWinEnter" }, { callback = ft_detect })
