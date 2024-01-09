return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	config = function()
		local lspsaga = require("lspsaga")
		lspsaga.setup({
			outline = {
				close_after_jump = true,
			},
			code_action = {
				extend_gitsigns = true,
			},
		})
	end,
}
