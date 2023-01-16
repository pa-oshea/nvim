return {
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects" },

	-- https://github.com/p00f/nvim-ts-rainbow
	{ "p00f/nvim-ts-rainbow" },

	-- https://github.com/andymass/vim-matchup
	{ "andymass/vim-matchup" },

	-- https://github.com/nvim-treesitter/nvim-treesitter-context
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	},
}
