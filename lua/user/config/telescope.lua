local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },

		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})

telescope.load_extension("ui-select")

local km = require("user.utils.keymapper")

km.wk.register({ ["<leader>f"] = { name = " Telescope" } }, { mode = "n" })
km.nkeymap("<leader>ff", "<cmd>Telescope find_files<cr>", "Find file")
km.nkeymap("<leader>fb", "<cmd>Telescope buffers<cr>", "Browse buffers")
km.nkeymap("<leader>fg", "<cmd>Telescope live_grep<cr>", "Live grep")
km.nkeymap("<leader>fp", "<cmd>Telescope projects<cr>", "Browse projects")
km.nkeymap("<leader>fr", "<cmd>Telescope lsp_references<cr>", "Browse references")
