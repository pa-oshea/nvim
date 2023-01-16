require("core")

if vim.g.neovide then
	vim.o.guifont = "JetBrains Mono:h10.5"
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
