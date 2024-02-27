return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPost",
	config = function()
		require("gitsigns").setup({
			current_line_blame = true,
			numhl = true,
		})
	end,
}
