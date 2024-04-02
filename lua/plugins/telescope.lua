return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})
		end,
	},
	--  Telescope [search] + [search backend] dependency
	--  https://github.com/nvim-telescope/telescope.nvim
	--  https://github.com/nvim-telescope/telescope-fzf-native.nvim
	--  https://github.com/debugloop/telescope-undo.nvim
	--  NOTE: Normally, plugins that depend on Telescope are defined separately.
	--  But its Telescope extension is added in the Telescope 'config' section.
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"debugloop/telescope-undo.nvim",
				cmd = "Telescope",
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				enabled = vim.fn.executable("make") == 1,
				build = "make",
			},
			"nvim-telescope/telescope-ui-select.nvim",
		},
		cmd = "Telescope",
		opts = function()
			local get_icon = require("core.utils").get_icon
			local actions = require("telescope.actions")
			local mappings = {
				i = {
					["<C-h>"] = actions.cycle_history_next,
					["<C-l>"] = actions.cycle_history_prev,
					["<C-j>"] = actions.move_selection_next,
					["<C-n>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-p>"] = actions.move_selection_previous,
					["<ESC>"] = actions.close,
					["<C-c>"] = false,
				},
				n = { ["q"] = actions.close },
			}
			return {
				defaults = {
					prompt_prefix = get_icon("Search", 1),
					selection_caret = get_icon("Selected", 1),
					path_display = { "truncate" },
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.50,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					mappings = mappings,
				},
				extensions = {
					undo = {
						use_delta = true,
						side_by_side = true,
						diff_context_lines = 0,
						entry_format = "󰣜 #$ID, $STAT, $TIME",
						layout_strategy = "horizontal",
						layout_config = {
							preview_width = 0.65,
						},
						mappings = {
							i = {
								["<cr>"] = require("telescope-undo.actions").yank_additions,
								["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
								["<C-cr>"] = require("telescope-undo.actions").restore,
							},
						},
					},
				},
			}
		end,
		config = function(_, opts)
			local utils = require("core.utils")
			local telescope = require("telescope")
			telescope.setup(opts)
			-- Here we define the Telescope extension for all plugins.
			-- If you delete a plugin, you can also delete its Telescope extension.
			utils.conditional_func(telescope.load_extension, utils.is_available("nvim-notify"), "notify")
			utils.conditional_func(telescope.load_extension, utils.is_available("telescope-fzf-native.nvim"), "fzf")
			utils.conditional_func(telescope.load_extension, utils.is_available("ui-select"), "ui select")
			utils.conditional_func(telescope.load_extension, utils.is_available("telescope-undo.nvim"), "undo")
			utils.conditional_func(telescope.load_extension, utils.is_available("nvim-neoclip.lua"), "neoclip")
			utils.conditional_func(telescope.load_extension, utils.is_available("nvim-neoclip.lua"), "macroscope")
			utils.conditional_func(telescope.load_extension, utils.is_available("project.nvim"), "projects")
			utils.conditional_func(telescope.load_extension, utils.is_available("LuaSnip"), "luasnip")
			utils.conditional_func(telescope.load_extension, utils.is_available("aerial.nvim"), "aerial")
		end,
	},
}
