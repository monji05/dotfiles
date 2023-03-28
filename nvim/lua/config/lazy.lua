local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.api.nvim_command([[
  syntax off
  filetype plugin indent off
  filetype off
]])

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
  change_detection = {
    enabled = false,
    notify = false,     -- get a notification when changes are found
  },
  performance = {
    chache = {
      enabled = true,
    },
  },
  rtp = {
    disabled = {
      "gzip",
      "matchit",
      "matchparen",
      "netrwPlugin",
      "Jrplugin",
      "tarPlugin",
      "tohtml",
      "tutor",
      "zipPlugin",
    },
  },
  debug = false,
})
