return {
  {
    "sethen/line-number-change-mode.nvim",
    config = function()
      local config_options = {
        mode = {},
      }

      -- 現在のカラースキーム名を取得
      local current_scheme = vim.g.colors_name or ""

      if current_scheme:find("iceberg") then
        -- Iceberg仕様のハイライト（背景色と文字色）
        local iceberg_colors = {
          bg = "#161821",
          green = "#b4be82",
          blue = "#84a0c6",
          magenta = "#a093c7",
          red = "#e27878",
        }

        config_options.mode = {
          i = { bg = iceberg_colors.green, fg = iceberg_colors.bg }, -- insert
          n = { bg = iceberg_colors.blue, fg = iceberg_colors.bg }, -- normal
          v = { bg = iceberg_colors.magenta, fg = iceberg_colors.bg }, -- visual
          V = { bg = iceberg_colors.magenta, fg = iceberg_colors.bg }, -- line visual
          R = { bg = iceberg_colors.red, fg = iceberg_colors.bg }, -- replace
        }
      else
        -- solarized-osaka などのフォールバック設定
        local ok, color = pcall(require, "solarized-osaka.colors")
        if ok then
          config_options.mode = {
            i = { bg = color.default.green500, fg = color.default.base02 },
            n = { bg = color.default.blue500, fg = color.default.base02 },
            v = { bg = color.default.magenta500, fg = color.default.base02 },
            V = { bg = color.default.magenta500, fg = color.default.base02 },
            R = { bg = color.default.red500, fg = color.default.base02 },
          }
        end
      end

      require("line-number-change-mode").setup(config_options)
    end,
  },
}
