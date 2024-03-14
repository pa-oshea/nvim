return {
	{
		"lewis6991/gitsigns.nvim",
		enabled = vim.fn.executable("git") == 1,
		event = "User BaseGitFile",
		opts = {
			max_file_length = vim.g.big_file.lines,
			current_line_blame = true,
			numhl = true,
		},
	},
	{ "sindrets/diffview.nvim" },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},
}
