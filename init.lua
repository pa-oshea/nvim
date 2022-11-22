require "user.config.impatient"
require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.config.autocommands"
require "user.colorscheme"
require "user.config.cmp"
require "user.config.telescope"
require "user.config.gitsigns"
require "user.config.treesitter"
require "user.config.autopairs"
require "user.config.comment"
require "user.config.nvim-tree"
require "user.config.bufferline"
require "user.config.lualine"
require "user.config.toggleterm"
require "user.config.project"
require "user.config.illuminate"
require "user.config.indentline"
require "user.config.alpha"
require "user.lsp"
require "user.config.dap"

if vim.g.neovide then
    vim.o.guifont = "JetBrains Mono:h10.0"
    vim.g.noevide_scale_factor = 1
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_hide_mouse_when_typing = true
end
