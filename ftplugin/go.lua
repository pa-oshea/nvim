local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

which_key.register({
	c = {
		name = "󰑮 Go",
		t = {
			function()
				require("dap-go").debug_test()
			end,
			"Debug Test",
		},
		l = {
			function()
				require("dap-go").debug_last()
			end,
			"Debug last test",
		},
	},
}, {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
})
