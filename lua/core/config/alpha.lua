local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	vim.notify("Alpha not loaded", "error")
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[                               __                ]],
	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
dashboard.section.buttons.val = {
	-- dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
	-- dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", " " .. " Find project", "<cmd>Telescope projects theme=dropdown previewer=false<cr>"),
	dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
	-- dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
	dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}

local function get_neovim_version()
	local v = vim.version()
	return "v" .. tostring(v.major) .. "." .. tostring(v.minor) .. "." .. tostring(v.patch)
end

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.section.footer.val = " Neovim " .. get_neovim_version()

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
