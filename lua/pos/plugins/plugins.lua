return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
	},
	{ "stevearc/oil.nvim", config = true },
	{ "nvim-lua/plenary.nvim" },
	{ "fladson/vim-kitty" },
	{ "MunifTanjim/nui.nvim" },
	{
		"kylechui/nvim-surround",
		config = true,
	},
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPost",
		config = true,
	},
	{ "mbbill/undotree", cmd = { "Undotree", "UndotreeToggle" } },
	{
		"norcalli/nvim-colorizer.lua",
		config = true,
	},

	-- Icons
	{
		"glepnir/nerdicons.nvim",
		cmd = "NerdIcons",
		config = true,
	},
	{
		"otavioschwanck/arrow.nvim",
		opts = {
			show_icons = true,
			leader_key = ";", -- Recommended to be a single key
		},
	},
}
