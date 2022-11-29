local surround = require("mini.surround")
local wk = require("which-key")

surround.setup({
	custom_surroundings = nil,
	highlight_duration = 500,
	mappings = {
		add = "<space>S",
		delete = "<space>Sd",
		find = "<space>Sf",
		find_left = "<space>SF",
		highlight = "<spaceSh",
		replace = "<space>Sc",
		update_n_lines = "<space>Sn",
	},
	n_lines = 20,
	search_method = "cover",
})

wk.register({ ["<leader>S"] = { name = " Surround" } })
wk.register({ ["<leader>Sd"] = { name = "Delete" } })
wk.register({ ["<leader>Sf"] = { name = "Find Forward" } })
wk.register({ ["<leader>SF"] = { name = "Find Back" } })
wk.register({ ["<leader>Sh"] = { name = "Highlight" } })
wk.register({ ["<leader>Sc"] = { name = "Replace" } })
wk.register({ ["<leader>Sn"] = { name = "Update 20 lines" } })
