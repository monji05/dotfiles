-- 診断のフローティングウィンドウ設定
vim.diagnostic.config({
  float = {
    border = "rounded", -- "single", "double", "solid", "shadow" などから選択
    source = "always", -- どのLSP・ツールの診断かを表示する（任意）
  },
})
