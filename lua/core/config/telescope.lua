local telescope_status, telescope = pcall(require, "telescope")
if not telescope_status then
	vim.notify("Telescope could not load", "error")
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/" },
		sorting_strategy = "ascending",
		layout_config = {
			mirror = false,
			prompt_position = "top",
		},
		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
			live_grep = {
				--@usage don't include the filename in the search results
				only_sort_text = true,
			},
			grep_string = {
				only_sort_text = true,
			},
			buffers = {
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
			planets = {
				show_pluto = true,
				show_moon = true,
			},
			git_files = {
				hidden = true,
				show_untracked = true,
			},
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
