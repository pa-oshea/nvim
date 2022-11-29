local wk = require("which-key")

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
