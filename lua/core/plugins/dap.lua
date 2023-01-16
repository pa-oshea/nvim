return {

	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui"},
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end,
	},
}
