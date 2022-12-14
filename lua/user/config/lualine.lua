local lualine = require("lualine")

local location = {
	"location",
	padding = 0,
}

-- local spaces = function()
-- 	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
-- end
-- spaces, "encoding",

lualine.setup({
	options = {
		globalstatus = false,
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "diff" },
		lualine_x = { "diagnostics", "filetype" },
		lualine_y = { location },
		lualine_z = { "progress" },
	},
})
