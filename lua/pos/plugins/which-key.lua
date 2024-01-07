return {

	"folke/which-key.nvim",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local terminal = require("toggleterm.terminal").Terminal

		local toggle_float = function()
			local float = terminal:new({ direction = "float" })
			return float:toggle()
		end

		local toggle_lazygit = function()
			local lazygit = terminal:new({ cmd = "lazygit", direction = "float" })
			return lazygit:toggle()
		end
		local which_key = require("which-key")
		which_key.setup({
			window = {
				border = "double",
			},
		})

		local mappings = {

			[";"] = { "<cmd>Alpha<CR>", "Dashboard" },
			["w"] = { "<cmd>w!<CR>", "Save" },
			["q"] = { "<cmd>confirm q<CR>", "Quit" },
			["f"] = { "<cmd>Telescope find_files<cr>", "Find file" },
			["u"] = { "<cmd>UndotreeToggle<cr>", "Undo tree" },
			["p"] = { '"_dP', "Paste wihout changing copy register" },
			["r"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace word under cursor" },
			b = {
				-- TODO: Better buffer handling
				name = "Buffers",
				j = { "<cmd>BufferLinePick<cr>", "Jump" },
				f = { "<cmd>Telescope buffers<cr>", "Find" },
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
				q = { "<cmd>lua require'dap'.terminate()<cr>", "Quit" },
				U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
			},
			e = {
				name = "Explorer",
				e = { "<cmd>Neotree toggle<cr>", "Neo tree" },
				o = { "<cmd>Oil<CR>", "Oil" },
				b = {
					"<cmd>Neotree source=buffers toggle<cr>",
					"Neo tree buffers",
				},
			},
			g = {
				name = "Git",
				-- TODO: sort git stuff
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
				-- TODO: better key map, and code action shit
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
				o = { "<cmd>SymbolsOutline<cr>", "Toggle symbols outline" },
			},
			s = {
				name = "Search",
				b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				c = { "<cmd>Telescope commands<cr>", "Commands" },
				f = { "<cmd>Telescope git_files<cr>", "Find File" },
				h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
				H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
				M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
				r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
				R = { "<cmd>Telescope registers<cr>", "Registers" },
				t = { "<cmd>Telescope live_grep<cr>", "Text" },
				w = {
					function()
						require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
					end,
					"Search word under cursor",
				},
				W = {
					function()
						require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
					end,
					"Search full word under cursor",
				},
				k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
				p = { "<cmd>Telescope projects theme=dropdown previewer=false<cr>", "Projects" },
				n = {
					function()
						require("telescope").extensions.notify.notify()
					end,
					"Search notifications",
				},
			},
			t = {
				name = "Terminal",
				t = { ":ToggleTerm<cr>", "Split Below" },
				f = { toggle_float, "Floating Terminal" },
				l = { toggle_lazygit, "LazyGit" },
			},
			T = {
				name = "Treesitter",
				i = { ":TSConfigInfo<cr>", "Info" },
				u = { ":TSUpdate<cr>", "Update" },
			},
			x = {
				name = "Trouble",
				x = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
				w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
				d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
				t = { "<cmd>TodoTrouble<cr>", "Todo Trouble" },
				T = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
			},
			z = {
				name = "Zen",
				z = { "<cmd>ZenMode<cr>", "Zen mode" },
			},
		}

		which_key.register(mappings, {
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		})
	end,
	event = "VeryLazy",
}
