local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	c = {
		name = "Typescript",
		o = {
			function()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.organizeImports.ts" },
						diagnostics = {},
					},
				})
			end,
			"Organize Imports",
		},
		r = {
			function()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.removeUnused.ts" },
						diagnostics = {},
					},
				})
			end,
			"Remove Unused Imports",
		},
	},
}

which_key.register(mappings, opts)
