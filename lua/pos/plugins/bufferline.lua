return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				offsets = {
					{
						filetype = "neo-tree",
						text = "Explorer",
						highlight = "Directory",
						padding = 1,
					},
					{
						filetype = "NvimTree",
						text = "Explorer",
						highlight = "Directory",
						padding = 1,
					},
					{
						filetype = "undotree",
						text = "Undotree",
						highlight = "Directory",
						padding = 1,
					},
					{
						filetype = "DiffviewFiles",
						text = "Diff view",
						highlight = "Directory",
						padding = 1,
					},
				},
				diagnostics = "nvim_lsp",
				separator_style = { "", "" },
				modified_icon = "●",
				show_close_icon = false,
				show_buffer_close_icons = false,
			},
		})
	end,
}
