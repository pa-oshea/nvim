return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	config = function()
		local lspsaga = require("lspsaga")
		lspsaga.setup({
			ui = {
				code_action = "󰌵",
			},
			outline = {
				close_after_jump = true,
			},
			code_action = {
				extend_gitsigns = true,
			},
			symbol_in_winbar = {
				enable = false,
			},
			light_blub = {
				virtual_text = false,
			},
		})
	end,
}
