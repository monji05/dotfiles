return {
  'davidgranstrom/nvim-markdown-preview',
  ft = 'markdown',
  lazy = true,
  config = function()
    local status, preview = pcall(require, "preview")
    if (not status) then return end
    preview.setup()
    vim.api.nvim_command [[let g:nvim_markdown_preview_theme = 'solarized-dark']]
  end
}
