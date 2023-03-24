return {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	event = "BufRead",
	opts = {
		{
			automatic_installation = true,
		},
	},
}
