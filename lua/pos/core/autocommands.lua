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
	}

	define_autocmds(definitions)
end

load_defaults()
