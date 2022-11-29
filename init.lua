require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.colorscheme")
require("user.lsp")
require("user.config.cmp")
require("user.config.impatient")
require("user.config.better-escape")
require("user.config.autocommands")
require("user.config.telescope")
require("user.config.gitsigns")
require("user.config.treesitter")
require("user.config.autopairs")
require("user.config.comment")
require("user.config.nvim-tree")
require("user.config.bufferline")
require("user.config.lualine")
require("user.config.toggleterm")
require("user.config.project")
require("user.config.illuminate")
require("user.config.indentline")
require("user.config.alpha")
require("user.config.dap")
require("user.config.mini_surround")
require("user.config.numtoggle") -- some how this is active even without this require

if vim.g.neovide then
	vim.o.guifont = "JetBrains Mono:h10.0"
	vim.g.noevide_scale_factor = 1
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_refresh_rate_idle = 5
	vim.g.neovide_transparency = 0.97
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_cursor_trail_length = 0
end
