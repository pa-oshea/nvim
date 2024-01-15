return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")
		local null_ls_utils = require("null-ls.utils")
		local code_actions = null_ls.builtins.code_actions
		local sources = {
			code_actions.eslint_d.with({
				condition = function(utils)
					utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" })
				end,
			}),
		}
		null_ls.setup({
			root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
			sources = sources,
		})
	end,
}
