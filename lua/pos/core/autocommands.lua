local function enable_transparent_mode()
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			local hl_groups = {
				"Normal",
				"SignColumn",
				"NormalNC",
				"TelescopeBorder",
				"NvimTreeNormal",
				"EndOfBuffer",
				"MsgArea",
			}
			for _, name in ipairs(hl_groups) do
				vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
			end
		end,
	})
	vim.opt.fillchars = "eob: "
end

--- Create autocommand groups based on the passed definitions
--- Also creates the augroup automatically if it doesn't exist
---@param definitions table contains a tuple of event, opts, see `:h nvim_create_autocmd`
local function define_autocmds(definitions)
	for _, entry in ipairs(definitions) do
		local event = entry[1]
		local opts = entry[2]
		if type(opts.group) == "string" and opts.group ~= "" then
			local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
			if not exists then
				vim.api.nvim_create_augroup(opts.group, {})
			end
		end
		vim.api.nvim_create_autocmd(event, opts)
	end
end

local function load_defaults()
	local definitions = {
		{
			"TextYankPost",
			{
				group = "_general_settings",
				pattern = "*",
				desc = "Highlight text on yank",
				callback = function()
					vim.highlight.on_yank({ higroup = "Search", timeout = 100 })
				end,
			},
		},
		{
			"FileType",
			{
				group = "_hide_dap_repl",
				pattern = "dap-repl",
				command = "set nobuflisted",
			},
		},
		{
			"FileType",
			{
				group = "_filetype_settings",
				pattern = { "lua" },
				desc = "fix gf functionality inside .lua files",
				callback = function()
					---@diagnostic disable: assign-type-mismatch
					-- credit: https://github.com/sam4llis/nvim-lua-gf
					vim.opt_local.include = [[\v<((do|load)file|require|reload)[^''"]*[''"]\zs[^''"]+]]
					vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"
					vim.opt_local.suffixesadd:prepend(".lua")
					vim.opt_local.suffixesadd:prepend("init.lua")

					for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
						vim.opt_local.path:append(path .. "/lua")
					end
				end,
			},
		},
		{
			"FileType",
			{
				group = "_buffer_mappings",
				pattern = {
					"qf",
					"help",
					"man",
					"floaterm",
					"lspinfo",
					"lir",
					"lsp-installer",
					"null-ls-info",
					"tsplayground",
					"DressingSelect",
					"Jaq",
				},
				callback = function()
					vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
					vim.opt_local.buflisted = false
				end,
			},
		},
		{
			"VimResized",
			{
				group = "_auto_resize",
				pattern = "*",
				command = "tabdo wincmd =",
			},
		},
		{
			"FileType",
			{
				group = "_filetype_settings",
				pattern = "alpha",
				callback = function()
					vim.cmd([[
            nnoremap <silent> <buffer> q :qa<CR>
            nnoremap <silent> <buffer> <esc> :qa<CR>
            set nobuflisted
          ]])
				end,
			},
		},
		{
			"FileType",
			{
				group = "_filetype_settings",
				pattern = "lir",
				callback = function()
					vim.opt_local.number = false
					vim.opt_local.relativenumber = false
				end,
			},
		},
		{
			"ColorScheme",
			{
				group = "_lvim_colorscheme",
				callback = function()
					require("core.config.lsp.navic").get_winbar()
					local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
					local cursorline_hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
					local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
					vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
					vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
					vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
					vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
					vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = statusline_hl.background })
					vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = cursorline_hl.background })
					vim.api.nvim_set_hl(0, "SLBranchName", { fg = normal_hl.foreground, bg = cursorline_hl.background })
					vim.api.nvim_set_hl(
						0,
						"SLSeparator",
						{ fg = cursorline_hl.background, bg = statusline_hl.background }
					)
				end,
			},
		},
	}

	define_autocmds(definitions)
end

load_defaults()
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
-- 	callback = function()
-- 		vim.cmd([[
--       nnoremap <silent> <buffer> q :close<CR>
--       set nobuflisted
--     ]])
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "dap-repl",
--   callback = function(args)
--     vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
--   end,
-- })
--
-- -- vim.api.nvim_create_augroup(
-- -- 	 "FileType" ,
-- -- 	{
-- -- 		group = "_filetype_settings",
-- -- 		pattern = { "lua" },
-- -- 		desc = "fix gf functionality inside .lua files",
-- -- 		callback = function()
-- -- 			---@diagnostic disable: assign-type-mismatch
-- -- 			-- credit: https://github.com/sam4llis/nvim-lua-gf
-- -- 			vim.opt_local.include = [[\v<((do|load)file|require|reload)[^''"]*[''"]\zs[^''"]+]]
-- -- 			vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"
-- -- 			vim.opt_local.suffixesadd:prepend(".lua")
-- -- 			vim.opt_local.suffixesadd:prepend("init.lua")
-- --
-- -- 			for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
-- -- 				vim.opt_local.path:append(path .. "/lua")
-- -- 			end
-- -- 		end,
-- -- 	}
-- -- )
-- --
-- -- vim.api.nvim_create_augroup(
-- -- 	"FileType",
-- -- 	{
-- -- 		group = "_buffer_mappings",
-- -- 		pattern = {
-- -- 			"qf",
-- -- 			"help",
-- -- 			"man",
-- -- 			"floaterm",
-- -- 			"lspinfo",
-- -- 			"lir",
-- -- 			"lsp-installer",
-- -- 			"null-ls-info",
-- -- 			"tsplayground",
-- -- 			"DressingSelect",
-- -- 			"Jaq",
-- -- 		},
-- -- 		callback = function()
-- -- 			vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
-- -- 			vim.opt_local.buflisted = false
-- -- 		end,
-- -- 	}
-- -- )
-- --
-- -- vim.api.nvim_create_augroup(
-- -- 	"VimResized",
-- -- 	{
-- -- 		group = "_auto_resize",
-- -- 		pattern = "*",
-- -- 		command = "tabdo wincmd =",
-- -- 	}
-- -- )
-- --
-- -- vim.api.nvim_create_augroup(
-- -- 	"ColorScheme",
-- -- 	{
-- -- 		group = "_lvim_colorscheme",
-- -- 		callback = function()
-- -- 			require("core.config.lsp.navic").get_winbar()
-- -- 			local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
-- -- 			local cursorline_hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
-- -- 			local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
-- -- 			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
-- -- 			vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
-- -- 			vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
-- -- 			vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
-- -- 			vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = statusline_hl.background })
-- -- 			vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = cursorline_hl.background })
-- -- 			vim.api.nvim_set_hl(0, "SLBranchName", { fg = normal_hl.foreground, bg = cursorline_hl.background })
-- -- 			vim.api.nvim_set_hl(0, "SLSeparator", { fg = cursorline_hl.background, bg = statusline_hl.background })
-- -- 		end,
-- -- 	}
-- -- )
--
-- -- vim.api.nvim_creat
-- -- TODO find out what this is and can it be done for neotree
-- -- vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")
--
-- -- Highlight yanked text
-- vim.api.nvim_create_autocmd({ "TextYankPost" }, {
-- 	callback = function()
-- 		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
-- 	end,
-- })
--
-- -- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- -- 	pattern = { "*.java" },
-- -- 	callback = function()
-- -- 		vim.lsp.codelens.refresh()
-- -- 	end,
-- -- })
--
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
-- 	callback = function()
-- 		vim.cmd("hi link illuminatedWord LspReferenceText")
-- 	end,
-- })

-- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
-- 	callback = function()
-- 		local line_count = vim.api.nvim_buf_line_count(0)
-- 		if line_count >= 5000 then
-- 			vim.cmd("IlluminatePauseBuf")
-- 		end
-- 	end,
-- })
