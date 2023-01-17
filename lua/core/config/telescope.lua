---@alias telescope_themes
---| "cursor"   # see `telescope.themes.get_cursor()`
---| "dropdown" # see `telescope.themes.get_dropdown()`
---| "ivy"      # see `telescope.themes.get_ivy()`
---| "center"   # retain the default telescope theme
local M = {}

function M.config()
	local actions = require("telescope.actions")
	return {
		defaults = {
			theme = "dropdown",
			prompt_prefix = " ",
			selection_caret = " ",
			path_display = { "smart" },
			file_ignore_patterns = {
				".git/",
				"target/",
				"docs/",
				"vendor/*",
				"%.lock",
				"__pycache__/*",
				"%.sqlite3",
				"%.ipynb",
				"node_modules/*",
				"%.svg",
				"%.otf",
				"%.ttf",
				"%.webp",
				".dart_tool/",
				".github/",
				".gradle/",
				".idea/",
				".settings/",
				".vscode/",
				"__pycache__/",
				"build/",
				"env/",
				"gradle/",
				"node_modules/",
				"%.pdb",
				"%.dll",
				"%.class",
				"%.exe",
				"%.cache",
				"%.ico",
				"%.pdf",
				"%.dylib",
				"%.jar",
				"%.docx",
				"%.met",
				"smalljre_*/*",
				".vale/",
				"%.burp",
				"%.mp4",
				"%.mkv",
				"%.rar",
				"%.zip",
				"%.7z",
				"%.tar",
				"%.bz2",
				"%.epub",
				"%.flac",
				"%.tar.gz",
			},
			sorting_strategy = "ascending",
			-- layout_config = {
			-- 	mirror = false,
			-- 	prompt_position = "top",
			-- },
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!.git/",
			},
			border = {},
			borderchars = nil,
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" },
			mappings = {
				i = {
					["<Down>"] = actions.cycle_history_next,
					["<Up>"] = actions.cycle_history_prev,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
			},
		},
		pickers = {
			find_files = {
				theme = "dropdown",
				previewer = false,
				hidden = true,
			},
			commands = {
				theme = "dropdown",
			},
			help_tags = {
				theme = "dropdown",
			},
			highlights = {
				theme = "dropdown",
			},
			man_pages = {
				theme = "dropdown",
			},
			oldfiles = {
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
				theme = "dropdown",
				--@usage don't include the filename in the search results
				only_sort_text = true,
			},
			grep_string = {
				theme = "dropdown",
				only_sort_text = true,
			},
			buffers = {
				theme = "dropdown",
				previewer = false,
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
	}
end

function M.setup()
	local telescope = require("telescope")
	telescope.setup(M.config())

	telescope.load_extension("notify")
	telescope.load_extension("ui-select")
	telescope.load_extension("fzf")
	telescope.load_extension("projects")
end

return M
