return {
  "https://github.com/nvim-lualine/lualine.nvim",
  config = function()
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
  end,
}
