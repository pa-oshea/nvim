local M = {}

function M.config()
	return {
		plugins = {
			marks = false, -- shows a list of your marks on ' and `
			registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = true,
				suggestions = 30,
			}, -- use which-key for spelling hints
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = true, -- adds help for operators like d, y, ...
				motions = true, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		-- add operators that will trigger motion and text object completion
		-- to enable all native operators, set the preset / operators plugin above
		operators = { gc = "Comments" },
		key_labels = {
			-- override the label used to display some keys. It doesn't effect WK in any other way.
			-- For example:
			-- ["<space>"] = "SPC",
			-- ["<cr>"] = "RET",
			-- ["<tab>"] = "TAB",
		},
		icons = {
			-- symbol used in the command line area that shows your active key combo
			breadcrumb = "»",
			-- symbol used between a key and it's label
			separator = "➜",
			-- symbol prepended to a group
			group = "+",
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 0,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true, -- show help message on the command line when the popup is visible
		show_keys = true, -- show the currently pressed key and its label as a message in the command line
		triggers = "auto", -- automatically setup triggers
		-- triggers = {"<leader>"} -- or specify a list manually
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			-- this is mostly relevant for key maps that start with a native binding
			-- most people should not need to change this
			i = { "j", "k" },
			v = { "j", "k" },
		},
		-- disable the WhichKey popup for certain buf types and file types.
		-- Disabled by deafult for Telescope
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	}
end

function M.nmappings()
	return {
		[";"] = { "<cmd>Alpha<CR>", "Dashboard" },
		["w"] = { "<cmd>w!<CR>", "Save" },
		["q"] = { "<cmd>confirm q<CR>", "Quit" },
		["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
		["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
		["f"] = { "<cmd>Telescope find_files theme=dropdown previewer=false<cr>", "Find file" },
		["u"] = { "<cmd>UndotreeToggle<cr>", "Undo tree" },
		["z"] = { "<cmd>Zenmode<cr>", "Toggle zen mode" },
		["e"] = { "<cmd>Neotree toggle<CR>", "Explorer" },
		["p"] = { '"_dP', "Paste wihout changing copy register" },
		b = {
			name = "Buffers",
			j = { "<cmd>BufferLinePick<cr>", "Jump" },
			f = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
			b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
			n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
			W = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
			e = {
				"<cmd>BufferLinePickClose<cr>",
				"Pick which buffer to close",
			},
			h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
			l = {
				"<cmd>BufferLineCloseRight<cr>",
				"Close all to the right",
			},
			D = {
				"<cmd>BufferLineSortByDirectory<cr>",
				"Sort by directory",
			},
			L = {
				"<cmd>BufferLineSortByExtension<cr>",
				"Sort by language",
			},
		},
		-- " Available Debug Adapters:
		-- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
		-- " Adapter configuration and installation instructions:
		-- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
		-- " Debug Adapter protocol:
		-- "   https://microsoft.github.io/debug-adapter-protocol/
		-- " Debugging
		d = {
			name = "Debug",
			t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
			T = {
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				"Set conditional breakpoint",
			},
			b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
			c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
			C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
			d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
			g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
			i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
			o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
			u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
			p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
			r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
			s = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
			q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
			U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
		},
		-- p = {
		-- 	name = "Plugins",
		-- 	i = { "<cmd>Lazy install<cr>", "Install" },
		-- 	s = { "<cmd>Lazy sync<cr>", "Sync" },
		-- 	S = { "<cmd>Lazy clear<cr>", "Status" },
		-- 	c = { "<cmd>Lazy clean<cr>", "Clean" },
		-- 	u = { "<cmd>Lazy update<cr>", "Update" },
		-- 	p = { "<cmd>Lazy profile<cr>", "Profile" },
		-- 	l = { "<cmd>Lazy log<cr>", "Log" },
		-- 	d = { "<cmd>Lazy debug<cr>", "Debug" },
		-- },

		g = {
			name = "Git",
			g = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
			j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
			k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
			l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
			p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
			r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
			R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
			s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
			u = {
				"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
				"Undo Stage Hunk",
			},
			o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
			b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
			C = {
				"<cmd>Telescope git_bcommits<cr>",
				"Checkout commit(for current file)",
			},
			d = {
				name = "Diff view",
				o = { "<cmd>DiffviewOpen<cr>", "Open diff view" },
				c = { "<cmd>DiffviewClose<cr>", "Close diff view" },
				r = { "<cmd>DiffviewRefresh<cr>", "Refresh diff view" },
				d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
			},
		},
		l = {
			name = "Lsp",
			f = {
				function()
					vim.lsp.buf.format({ async = true })
				end,
				"Format buffer",
			},
			l = { vim.lsp.codelens.run, "Codelens action" },
			d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer diagnostics" },
			w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
			i = { "<cmd>LspInfo<cr>", "Lsp info" },
			a = { "<cmd>Lspsaga code_action<cr>", "Code action" },
			j = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next diagnostic" },
			k = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Previous diagnostic" },
			r = { vim.lsp.buf.rename, "Rename" },
			h = { vim.lsp.buf.signature_help, "Signature help" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols" },
			S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbols" },
			e = { "<cmd>Telescope quickfix", "Telescope quickfix" },
			q = { vim.diagnostic.setloclist, "Quickfix" },
		},
		s = {
			name = "Search",
			b = { "<cmd>Telescope git_branches theme=dropdown<cr>", "Checkout branch" },
			c = { "<cmd>Telescope commands theme=dropdown<cr>", "Commands" },
			f = { "<cmd>Telescope git_files theme=dropdown<cr>", "Find File" },
			h = { "<cmd>Telescope help_tags theme=dropdown<cr>", "Find Help" },
			H = { "<cmd>Telescope highlights theme=dropdown<cr>", "Find highlight groups" },
			M = { "<cmd>Telescope man_pages theme=dropdown<cr>", "Man Pages" },
			r = { "<cmd>Telescope oldfiles theme=dropdown<cr>", "Open Recent File" },
			R = { "<cmd>Telescope registers theme=dropdown<cr>", "Registers" },
			t = { "<cmd>Telescope live_grep theme=dropdown<cr>", "Text" },
			k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			p = { "<cmd>Telescope projects theme=dropdown<cr>", "Projects" },
			n = {
				function()
					require("telescope").extensions.notify.notify()
				end,
				"Search notifications",
			},
		},
		x = {
			name = "Trouble",
			x = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
			w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
			d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
			t = { "<cmd>TodoTrouble<cr>", "Todo Trouble" },
			T = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
		},
		T = {
			name = "Treesitter",
			i = { ":TSConfigInfo<cr>", "Info" },
			u = { ":TSUpdate<cr>", "Update" },
		},
	}
end

function M.setup()
	local which_key = require("which-key")
	which_key.setup(M.config())

	which_key.register(M.nmappings(), {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	})
	-- which_key.register(mappings, opts)
end

return M
