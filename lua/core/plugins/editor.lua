return {
	-- Auto pairs https://github.com/windwp/nvim-autopairs
	{ "windwp/nvim-autopairs" },

	-- Nvim surround https://github.com/kylechui/nvim-surround
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},

	-- Nvim comment https://github.com/terrortylor/nvim-comment
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup()
		end,
	},

	-- https://github.com/norcalli/nvim-colorizer.lua
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- https://github.com/lewis6991/gitsigns.nvim
	{ "lewis6991/gitsigns.nvim" },

	-- https://github.com/lukas-reineke/indent-blankline.nvim
	{ "lukas-reineke/indent-blankline.nvim" },

	-- https://github.com/RRethy/vim-illuminate
	{ "RRethy/vim-illuminate" },

	-- https://github.com/folke/zen-mode.nvim
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup()
		end,
	},

	-- Folding https://github.com/kevinhwang91/nvim-ufo
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
	},
}
