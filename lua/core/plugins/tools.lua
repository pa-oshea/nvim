return {
	-- lua functions for neovim
	-- https://github.com/nvim-lua/plenary.nvim
	{ "nvim-lua/plenary.nvim" },

	-- https://github.com/mbbill/undotree
	{ "mbbill/undotree" },

	-- https://github.com/sindrets/diffview.nvim
	{ "sindrets/diffview.nvim" },

	-- https://github.com/ahmedkhalf/project.nvim
	{ "ahmedkhalf/project.nvim" },

	-- https://github.com/simrat39/symbols-outline.nvim
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	},

	-- neo test https://github.com/nvim-neotest/neotest#usage
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/neotest-go",
			"haydenmeade/neotest-jest",
		}
	},

	-- trouble https://github.com/folke/trouble.nvim
	{
		"folke/trouble.nvim",
		config = function ()
			require("trouble").setup()
		end
	}
}
