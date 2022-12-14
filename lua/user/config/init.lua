require(... .. ".alpha")
require(... .. ".autocommands")
require(... .. ".autopairs")
require(... .. ".bufferline")
require(... .. ".cmp")
require(... .. ".comment")
require(... .. ".dap")
require(... .. ".dressing")
require(... .. ".gitsigns")
require(... .. ".illuminate")
require(... .. ".indentline")
require(... .. ".lualine")
require(... .. ".nvim-tree")
require(... .. ".project")
require(... .. ".telescope")
require(... .. ".toggleterm")
require(... .. ".treesitter")
require(... .. ".whichkey")

vim.notify = require("notify")
-- Used for the ufo plugin
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require("neodev").setup()
require("ufo").setup()
require("better_escape").setup()
-- require("numbertoggle").setup()
require("impatient").enable_profile()
require("lsp-colors").setup()
require("fidget").setup()
require("symbols-outline").setup()
require("smart-splits").setup({
	ignored_filetypes = {
		"nofile",
		"quickfix",
		"qf",
		"prompt",
	},
	ignored_buftypes = {
		"nofile",
		"NvimTree",
	},
})
-- require("go").setup()
require("user.config.navic").setup()
require("nvim-surround").setup()
require("colorizer").setup()
require("treesitter-context").setup()
-- require("decay").setup({
--     style = "dark", -- dacayce, normal, dark
--     nvim_tree = {
--         contrast = true
--     }
-- })
