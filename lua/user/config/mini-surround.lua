local surround = require("mini.surround")
local wk = require("which-key")

surround.setup({
	custom_surroundings = nil,
	highlight_duration = 500,
	mappings = {
		add = "<space>s",
		delete = "<space>Sd",
		find = "<space>sf",
		find_left = "<space>sF",
		highlight = "<spacesh",
		replace = "<space>sc",
		update_n_lines = "<space>sn",
	},
	n_lines = 20,
	search_method = "cover",
})

wk.register({ ["<leader>s"] = { name = " Surround" } })
wk.register({ ["<leader>sd"] = { name = "Delete" } })
wk.register({ ["<leader>sf"] = { name = "Find Forward" } })
wk.register({ ["<leader>sF"] = { name = "Find Back" } })
wk.register({ ["<leader>sh"] = { name = "Highlight" } })
wk.register({ ["<leader>sc"] = { name = "Replace" } })
wk.register({ ["<leader>sn"] = { name = "Update 20 lines" } })
