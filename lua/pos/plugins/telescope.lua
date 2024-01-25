return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				layout_config = {
					width = 0.80,
					prompt_position = "top",
					preview_cutoff = 120,
					horizontal = { mirror = false },
					vertical = { mirror = false },
				},
				find_command = {
					"rg",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				prompt_prefix = "  ",
				selection_caret = "  ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				file_ignore_patterns = { ".git" },
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				path_display = {},
				winblend = 0,
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				use_less = true,
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<esc>"] = actions.close,
						["<CR>"] = actions.select_default + actions.center,
					},
					n = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				highlights = {
					theme = "dropdown",
				},
				registers = {
					theme = "dropdown",
				},
				git_branches = {
					theme = "dropdown",
				},
				keymaps = {
					theme = "dropdown",
				},
				live_grep = {
					--@usage don't include the filename in the search results
					only_sort_text = true,
				},
				grep_string = {
					theme = "dropdown",
					only_sort_text = true,
				},
				buffers = {
					theme = "dropdown",
					initial_mode = "normal",
					mappings = {
						i = {
							["<C-d>"] = actions.delete_buffer,
						},
						n = {
							["dd"] = actions.delete_buffer,
						},
					},
				},
				git_files = {
					theme = "dropdown",
					hidden = true,
					show_untracked = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		telescope.load_extension("notify")
		telescope.load_extension("ui-select")
		telescope.load_extension("fzf")
		telescope.load_extension("projects")
	end,
}
