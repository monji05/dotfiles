local status, preview = pcall(require, "preview")
if (not status) then return end

preview.setup()
vim.cmd([[let g:nvim_markdown_preview_theme = 'solarized-dark']])
