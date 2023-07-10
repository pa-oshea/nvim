local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local has_eslint_config = function(u)
	return u.root_has_file(".eslintrc") or u.root_has_file(".eslintrc.json") or u.root_has_file(".eslintrc.js")
end

local has_exec = function(exec)
	if vim.fn.executable(exec) == 1 then
		return true
	else
		return false
	end
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local code_actions = null_ls.builtins.code_actions

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
	debug = false,
	sources = {
		formatting.prettierd.with({
			condition = function()
				return has_exec("prettierd")
			end,
			env = {
				PRETTIERD_DEFAULT_CONFIG = vim.fn.getcwd() .. "/.prettierrc",
			},
		}),
		formatting.rustfmt,
		formatting.stylua,
		formatting.gofumpt,
		formatting.goimports,
		-- formatting.google_java_format,
		code_actions.eslint_d.with({
			condition = has_eslint_config,
			prefer_local = "node_modules/.bin",
		}),
		diagnostics.eslint_d.with({
			condition = has_eslint_config,
			prefer_local = "node_modules/.bin",
		}),
		-- FIXME: linters
		-- diagnostics.eslint_d,
		-- diagnostics.golangci_lint,
	},
})
