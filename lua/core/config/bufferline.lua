local bufferline = require("bufferline")

bufferline.setup({
	options = {
		diagnostics = "nvim_lsp",
		always_show_bufferline = false,
		offsets = {
			{
				filetype = "neo-tree",
				text = "Explorer",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "NvimTree",
				text = "Explorer",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "undotree",
				text = "Undotree",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "DiffviewFiles",
				text = "Diff view",
				highlight = "PanelHeading",
				padding = 1,
			},
		},
	},
})
-- options = {
-- 		close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
-- 		right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
-- 		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
-- 		separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
-- 		diagnostics = "nvim_lsp",
-- 	},
