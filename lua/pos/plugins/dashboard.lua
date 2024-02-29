return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		local function get_neovim_version()
			local v = vim.version()
			return "v" .. tostring(v.major) .. "." .. tostring(v.minor) .. "." .. tostring(v.patch)
		end
		require("dashboard").setup({
			-- config
			theme = "hyper",
			config = {
				week_header = {
					enable = true,
				},
				footer = {
					get_neovim_version(),
				},
				shortcut = {
					{ desc = "󰚰 Update", group = "@property", action = "Lazy update", key = "u" },
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Files",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
					},
					{
						desc = " Config",
						group = "Number",
						action = ":e $MYVIMRC",
						key = "c",
					},
					{
						desc = "󰿅 Quit",
						group = "DiagnosticHint",
						action = ":qa",
						key = "q",
					},
				},
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
