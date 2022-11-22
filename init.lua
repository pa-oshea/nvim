require "user.impatient"
require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.autocommands"
require "user.colorscheme"
require "user.cmp"
require "user.telescope"
require "user.gitsigns"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.illuminate"
require "user.indentline"
require "user.alpha"
require "user.lsp"
require "user.dap"

if vim.g.neovide then
    vim.o.guifont = "JetBrains Mono:h10.0"
    vim.g.noevide_scale_factor = 1
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_hide_mouse_when_typing = true
end
