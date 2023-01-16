local status, npairs = pcall(require, "nvim-autopairs")
if not status then
	vim.notify("Auto pairs failed to load", "error")
	return
end

npairs.setup({
	map_char = {
		all = "(",
		tex = "{",
	},
	enable_check_bracket_line = false,
	check_ts = true, -- treesitter integration
	disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
	ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
	enable_moveright = true,
	---@usage disable when recording or executing a macro
	disable_in_macro = false,
	---@usage add bracket pairs after quote
	enable_afterquote = true,
	---@usage map the <BS> key
	map_bs = true,
	---@usage map <c-w> to delete a pair if possible
	map_c_w = false,
	---@usage disable when insert after visual block mode
	disable_in_visualblock = false,
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0, -- Offset from pattern match
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
})

local ts_conds = require("nvim-autopairs.ts-conds")
local Rule = require("nvim-autopairs.rule")

npairs.add_rules({
	Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
	Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
})

local function on_confirm_done(...)
	require("nvim-autopairs.completion.cmp").on_confirm_done()(...)
end
pcall(function()
	require("nvim-autopairs.completion.cmp")
	require("cmp").event:off("confirm_done", on_confirm_done)
	require("cmp").event:on("confirm_done", on_confirm_done)
end)
