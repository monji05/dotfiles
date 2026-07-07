vim.lsp.enable({
  "gopls",
  "lua_ls",
  "intelephense",
  "ts_ls",
  "pyright",
})
vim.diagnostic.config({ virtual_text = true })


-- nvim-treesitterを手動で有効化しなければいけない
-- >> Neovim 0.11のリリースに伴ってmasterブランチは凍結され、現在はmainブランチで開発を継続しています。
-- >> 公式ではNeovim 0.11がでたらデフォルトブランチをmainブランチに変更するとしています。その割にmasterブランチがデフォルトのままですが、2025-05-24で更新が止まっているので、早々にmainブランチに切り替えたほうがいいでしょう。
-- TIPS: urlにカーソルを置いた状態でgxでブラウザに遷移できる
-- URL: https://blog.atusy.net/2025/08/10/nvim-treesitter-main-branch/

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
  callback = function(ctx)
    -- 必要に応じて`ctx.match`に入っているファイルタイプの値に応じて挙動を制御
    -- `pcall`でエラーを無視することでパーサーやクエリがあるか気にしなくてすむ
    pcall(vim.treesitter.start)
  end,
})

