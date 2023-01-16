return {
	-- LSP Support
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jayp0521/mason-nvim-dap.nvim" },
	{ "onsails/lspkind.nvim" },
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
	},
	{ "jose-elias-alvarez/null-ls.nvim" },
	{
		"folke/lsp-colors.nvim",
		config = function()
			require("lsp-colors").setup()
		end,
	},

	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},

	{ "folke/neodev.nvim" },

	-- https://github.com/SmiteshP/nvim-navic
	{
		"SmiteshP/nvim-navic",
		config = function()
			require("core.config.lsp.navic").setup()
		end,
	},
}
