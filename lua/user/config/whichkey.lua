local status_ok, wk = pcall(require, "which-key")
if not status_ok then
	return
end

wk.setup({
	icons = {
		-- symbol used in the command line area that shows your active key combo
		breadcrumb = "»",
		-- symbol used between a key and it's label
		separator = "➜",
		-- symbol prepended to a group
		group = "…",
	},
	spelling = { enabled = true, suggestions = 20 },
})
