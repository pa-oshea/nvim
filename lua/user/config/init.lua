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
require(... .. ".mini-surround")
require(... .. ".navic")
require(... .. ".notify")
require(... .. ".nvim-tree")
require(... .. ".project")
require(... .. ".telescope")
require(... .. ".toggleterm")
require(... .. ".treesitter")
require(... .. ".whichkey")

-- Used for the ufo plugin
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require("ufo").setup()
require("better_escape").setup()
require("numbertoggle").setup()
require("impatient").enable_profile()
