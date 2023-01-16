local M = {}

M.setup = function()
	local navic = require("nvim-navic")
	M.create_winbar()
	navic.setup({
		highlight = true,
		depth_limit = 0,
		depth_limit_indicator = "..",
	})
end

M.get_filename = function()
	local filename = vim.fn.expand("%:t")
	local extension = vim.fn.expand("%:e")
	local f = require("core.utils.functions")

	if not f.is_empty(filename) then
		local file_icon, hl_group = require("nvim-web-devicons").get_icon(filename, extension, { default = true })

		local navic_text = vim.api.nvim_get_hl_by_name("Normal", true)
		vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.foreground })

		return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
	end
end

local get_gps = function()
	local status_gps_ok, gps = pcall(require, "nvim-navic")
	if not status_gps_ok then
		return ""
	end

	local status_ok, gps_location = pcall(gps.get_location, {})
	if not status_ok then
		return ""
	end

	if not gps.is_available() or gps_location == "error" then
		return ""
	end

	if not require("core.utils.functions").is_empty(gps_location) then
		return "%#NavicSeparator#" .. ">" .. "%* " .. gps_location
	else
		return ""
	end
end

local excludes = function()
	return vim.tbl_contains({
		"help",
		"startify",
		"dashboard",
		"packer",
		"neo-tree",
		"neogitstatus",
		"NvimTree",
		"Trouble",
		"alpha",
		"lir",
		"Outline",
		"spectre_panel",
		"toggleterm",
		"DressingSelect",
		"Jaq",
		"harpoon",
		"dap-repl",
		"dap-terminal",
		"dapui_console",
		"dapui_hover",
		"lab",
		"notify",
		"noice",
		"",
	} or {}, vim.bo.filetype)
end

M.get_winbar = function()
	if excludes() then
		return
	end
	local f = require("core.utils.functions")
	local value = M.get_filename()

	local gps_added = false
	if not f.is_empty(value) then
		local gps_value = get_gps()
		value = value .. " " .. gps_value
		if not f.is_empty(gps_value) then
			gps_added = true
		end
	end

	if not f.is_empty(value) and f.get_buf_option("mod") then
		local mod = "%#LspCodeLens#" .. "" .. "%*"
		if gps_added then
			value = value .. " " .. mod
		else
			value = value .. mod
		end
	end

	local num_tabs = #vim.api.nvim_list_tabpages()

	if num_tabs > 1 and not f.is_empty(value) then
		local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
		value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
	end

	local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
	if not status_ok then
		return
	end
end

M.create_winbar = function()
	vim.api.nvim_create_augroup("_winbar", {})
	if vim.fn.has("nvim-0.8") == 1 then
		vim.api.nvim_create_autocmd(
			{ "CursorHoldI", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
			{
				group = "_winbar",
				callback = function()
					local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
					if not status_ok then
						require("core.config.lsp.navic").get_winbar()
					end
				end,
			}
		)
	end
end

return M
