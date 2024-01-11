return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		lualine.setup({
			options = {
				globalstatus = true,
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "dashboard", "telescope" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { "diff" },
				lualine_x = { "diagnostics", "filetype" },
				lualine_y = { "tabs" },
				lualine_z = { "progress" },
			},
			winbar = {
				lualine_a = {
					{
						"filename",
						show_modified_status = true,
						use_mode_colors = true,
						symbols = {
							modified = " ●",
							alternate_file = "",
							directory = "",
						},
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {
					{
						"filename",
						show_modified_status = true,
						use_mode_colors = true,
						symbols = {
							modified = " ●",
							alternate_file = "",
							directory = "",
						},
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
