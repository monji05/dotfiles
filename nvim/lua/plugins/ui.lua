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

-- colorizer
require("colorizer").setup({
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue or blue
    RRGGBBAA = false, -- #RRGGBBAA hex codes
    AARRGGBB = false, -- 0xAARRGGBB hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes for `mode`: foreground, background,  virtualtext
    mode = "background", -- Set the display mode.
    -- Available methods are false / true / "normal" / "lsp" / "both"
    -- True is same as normal
    tailwind = true, -- Enable tailwind colors
    -- parsers can contain values used in |user_default_options|
    sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
    virtualtext = "■",
    -- update color values even if buffer is not focused
    -- example use: cmp_menu, cmp_docs
    always_update = false,
  },
})

-- mini.icons
require("mini.icons").setup({
  extension = {
    ["php"] = {
      glyph = "",
      hl = "MiniIconsPurple",
    },
    ["blade.php"] = {
      glyph = "󰫐",
      hl = "MiniIconsRed",
    },
    ["composer.lock"] = {
      glyph = "",
      hl = "MiniIconsRed",
    },
  },
})

require("tiny-cmdline").setup({
  position = {
    y = "20%",
  },
})
