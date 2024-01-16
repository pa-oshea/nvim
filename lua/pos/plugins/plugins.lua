return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
	},
	{ "fladson/vim-kitty" },
	{ "MunifTanjim/nui.nvim" },
	{
		"kylechui/nvim-surround",
		config = true,
	},
	{
		"terrortylor/nvim-comment",
		config = true,
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPost",
		config = true,
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opt = { use_default_keymaps = false },
	},
	{ "mbbill/undotree", cmd = { "Undotree", "UndotreeToggle" } },
	{
		"norcalli/nvim-colorizer.lua",
		config = true,
	},
	-- GIT
	{ "sindrets/diffview.nvim" },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},

	-- LSP
	{
		"folke/lsp-colors.nvim",
		config = true,
	},
	{
		"j-hui/fidget.nvim",
		config = true,
		tag = "legacy",
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = true,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = true,
	},

	-- Zen mode
	{ "folke/zen-mode.nvim" },
	{ "folke/twilight.nvim" },

	-- Icons
	{
		"glepnir/nerdicons.nvim",
		cmd = "NerdIcons",
		config = true,
	},
}
