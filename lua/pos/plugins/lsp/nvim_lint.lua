return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			go = { "golangcilint" },
			javascript = { { "eslint_d", "eslint" } },
			typescript = { { "eslint_d", "eslint" } },
			javascriptreact = { { "eslint_d", "eslint" } },
			typescriptreact = { { "eslint_d", "eslint" } },
			svelte = { { "eslint_d", "eslint" } },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>lx", function()
			lint.try_lint()
		end, { desc = "Run linter" })
	end,
}
