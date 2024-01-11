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

		vim.keymap.set("n", "<leader>lx", function()
			lint.try_lint()
		end, { desc = "Run linter" })
	end,
}
