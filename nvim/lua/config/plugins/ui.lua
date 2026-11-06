local colors = require("solarized-osaka.colors").setup()
local devicons = require("nvim-web-devicons")

require("incline").setup({
  highlight = {
    groups = {
      InclineNormal = { guibg = colors.orange500, guifg = colors.base04 },
      InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
    },
  },
  hide = {
    cursorline = true,
  },
  window = {
    placement = {
      horizontal = "center",
      vertical = "top",
    },
    margin = {
      vertical = 0,
      horizontal = 0,
    },
  },

  render = function(props)
    -- 現在のバッファのプロジェクトルートからの相対パスを取得
    local bufpath = vim.api.nvim_buf_get_name(props.buf)
    if bufpath == "" then
      return "[No Name]"
    end

    local relpath = vim.fn.fnamemodify(bufpath, ":~:.")
    local filename = vim.fn.fnamemodify(bufpath, ":t")
    local dirpath = vim.fn.fnamemodify(relpath, ":h")

    -- ルート直下でない場合は末尾にスラッシュを付与
    if dirpath ~= "." then
      dirpath = dirpath .. "/"
    else
      dirpath = ""
    end
    local ft_icon, ft_color = devicons.get_icon_color(filename)
    local separator = { "┊ ", guifg = colors.blue }

    local is_modified = {}
    if vim.bo[props.buf].modified then
      table.insert(is_modified, { " ", guifg = colors.green300 })
    end
    return {
      -- { show_git_branch() },
      -- { get_diagnostic_label() },
      -- { get_git_diff() },
      { is_modified },
      { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
      { dirpath .. filename, gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
    }
  end,
})

-- render-markdown
require("render-markdown").setup({})

-- lualine
-- 現在のバッファにアタッチされているLSPクライアント名を返す
local function lsp_clients()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return ""
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return " " .. table.concat(names, ",")
end

-- インデックス中などの進捗メッセージ(例: "intelephense: Indexing 45%")
local function lsp_progress()
  local status = vim.lsp.status()
  -- 長すぎる場合は切り詰める
  if #status > 40 then
    status = status:sub(1, 40) .. "…"
  end
  return status
end

require("lualine").setup({
  options = {
    theme = "solarized_dark",
  },
  sections = {
    lualine_c = {
      { "filename", path = 1 },
      { lsp_progress },
    },
    lualine_x = {
      {
        lsp_clients,
        color = function()
          local has_client = #vim.lsp.get_clients({ bufnr = 0 }) > 0
          return { fg = has_client and "#859900" or "#dc322f" }
        end,
      },
      "encoding",
      "fileformat",
      "filetype",
    },
  },
})
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function()
    require("lualine").refresh()
  end,
})

-- treesitter
require("nvim-treesitter").setup({})

require("nvim-treesitter").install({
  "vim",
  "php",
  "diff",
  "lua",
  "json",
  "go",
  "javascript",
})
