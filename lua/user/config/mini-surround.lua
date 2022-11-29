local status_ok, surround = pcall(require, "surround")
if not status_ok then
	return
end

local ok, wk = pcall(require, "which-key")
if not ok then
	return
end

surround.setup({
	custom_surroundings = nil,
	highlight_duration = 500,
	mappings = {
		add = "S",
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
