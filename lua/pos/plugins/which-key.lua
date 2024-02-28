return {
	"folke/which-key.nvim",
	event = "VeryLazy",
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
				border = "single", -- none, single, double, shadow
			},
		})

		local mappings = {

			[";"] = { "<cmd>Alpha<CR>", "Dashboard" },
			["w"] = { "<cmd>w!<CR>", "Save" },
			["q"] = { "<cmd>confirm q<CR>", "Quit" },
			["f"] = { "<cmd>Telescope find_files<cr>", "Find file" },
			["u"] = { "<cmd>UndotreeToggle<cr>", "Undo tree" },
			["r"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace word under cursor" },
			b = {
				name = "Buffers",
				f = { "<cmd>Telescope buffers<cr>", "Find buffers" },
				W = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
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
				w = {
					function()
						local widgets = require("dap.ui.widgets")
						local sidebar = widgets.sidebar(widgets.scopes)
						sidebar.open()
					end,
					"Open debugging sidebar",
				},
			},
			e = {
				name = "Explorer",
				e = { "<cmd>Neotree toggle<cr>", "Neo tree" },
				b = {
					"<cmd>Neotree source=buffers toggle<cr>",
					"Neo tree buffers",
				},
			},
			g = {
				name = "Git",
				g = { "<cmd>Neogit<cr>", "Neogit" },
				j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
				k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
				l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
				p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
				s = {
					name = "stage",
					h = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
					j = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
					u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
					b = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage buffer" },
					n = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
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
					f = { "<cmd>DiffviewFileHistory<cr>", "File history" },
				},
			},
			l = {
				name = "Lsp",
				f = {
					function()
						require("conform").format()
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
				r = { "<cmd>Lspsaga rename<cr>", "Rename" },
				R = { "<cmd>Lspsaga finder<cr>", "Find references" },
				s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols" },
				S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbols" },
				e = { "<cmd>Telescope quickfix<cr>", "Telescope quickfix" },
				q = { vim.diagnostic.setloclist, "Quickfix" },
				o = { "<cmd>Lspsaga outline<cr>", "Toggle symbols outline" },
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
				j = { ":TSJToggle<cr>", "Toggle split join" },
				k = { ":TSJSplit<cr>", "Treesj split" },
				l = { ":TSJJoin<cr>", "Treesj join" },
			},
			x = {
				name = "Trouble",
				x = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
				w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
				d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
				t = { "<cmd>TodoTrouble<cr>", "Todo Trouble" },
				T = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
			},
			-- z = {
			-- 	name = "Zen",
			-- 	z = { "<cmd>ZenMode<cr>", "Zen mode" },
			-- },
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
}
