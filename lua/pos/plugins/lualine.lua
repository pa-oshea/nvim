return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local location = {
			"location",
			padding = 0,
		}

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
				lualine_c = { "filename", "diff" },
				lualine_x = { "diagnostics", "filetype" },
				lualine_y = { location },
				lualine_z = { "progress" },
			},
		})
	end,
}
