vim.lsp.enable({
	"gopls",
	"lua_ls",
	"intelephense",
	"ts_ls",
	"pyright",
})
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
	callback = function(ctx)
		pcall(vim.treesitter.start)
		if ctx.match == "php" then
			vim.bo[ctx.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
