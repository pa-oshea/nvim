-- User interface
-- Plugins that effect the look and feel

--    Sections:
--       -> catppuccin 					[theme]
--       -> dashboard	                [greeter]
--       -> nvim-notify                 [notifications]
--       -> indent-blankline            [guides]
--       -> lualine                    	[status line]
--       -> dressing.nvim               [better ui elements]
--       -> noice.nvim                  [better cmd/search line]
--       -> nvim-web-devicons           [icons | ui]
--       -> lspkind.nvim                [icons | lsp]
--       -> nvim-scrollbar              [scrollbar]
--       -> highlight-undo              [highlights]
--       -> vim-illuminate              [highlights]
--       -> todo-comments               [highlights]
--       -> nvim-colorizer              [highlights]
--       -> which-key                   [on-screen keybinding]

return {

	-- catppuccin [theme]
	-- https://github.com/catppuccin/nvim
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
	},

	-- dashboard [greeter]
	-- https://github.com/nvimdev/dashboard-nvim
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			local function get_neovim_version()
				local v = vim.version()
				return "v" .. tostring(v.major) .. "." .. tostring(v.minor) .. "." .. tostring(v.patch)
			end
			require("dashboard").setup({
				-- config
				theme = "hyper",
				config = {
					week_header = {
						enable = true,
					},
					footer = {
						get_neovim_version(),
					},
					shortcut = {
						{ desc = "󰚰 Update", group = "@property", action = "Lazy update", key = "u" },
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = " Config",
							group = "Number",
							action = ":e $MYVIMRC",
							key = "c",
						},
						{
							desc = "󰿅 Quit",
							group = "DiagnosticHint",
							action = ":qa",
							key = "q",
						},
					},
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},

	--  nvim-notify [notifications]
	--  https://github.com/rcarriga/nvim-notify
	{
		"rcarriga/nvim-notify",
		init = function()
			require("core.utils").load_plugin_with_func("nvim-notify", vim, "notify")
		end,
		opts = {
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 175 })
				if not vim.g.notifications_enabled then
					vim.api.nvim_win_close(win, true)
				end
				if not package.loaded["nvim-treesitter"] then
					pcall(require, "nvim-treesitter")
				end
				vim.wo[win].conceallevel = 3
				local buf = vim.api.nvim_win_get_buf(win)
				if not pcall(vim.treesitter.start, buf, "markdown") then
					vim.bo[buf].syntax = "markdown"
				end
				vim.wo[win].spell = false
			end,
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	},

	-- indent-blankline [guides]
	-- https://github.com/lukas-reineke/indent-blankline.nvim
	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({
				exclude = {
					filetypes = { "dashboard" },
				},
			})
		end,
	},

	-- lualine [status line]
	-- https://github.com/nvim-lualine/lualine.nvim
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local lualine = require("lualine")

			lualine.setup({
				options = {
					globalstatus = true,
					icons_enabled = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = { "alpha", "dashboard", "telescope" },
					always_divide_middle = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = { "diff" },
					lualine_x = { "diagnostics", "filetype" },
					lualine_y = { "tabs" },
					lualine_z = { "progress" },
				},
				winbar = {
					lualine_a = {
						{
							"filename",
							show_modified_status = true,
							use_mode_colors = true,
							symbols = {
								modified = " ●",
								alternate_file = "",
								directory = "",
							},
						},
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_winbar = {
					lualine_a = {
						{
							"filename",
							show_modified_status = true,
							use_mode_colors = true,
							symbols = {
								modified = " ●",
								alternate_file = "",
								directory = "",
							},
						},
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},

	--  [better ui elements]
	--  https://github.com/stevearc/dressing.nvim
	{
		"stevearc/dressing.nvim",
		init = function()
			require("core.utils").load_plugin_with_func("dressing.nvim", vim.ui, { "input", "select" })
		end,
		opts = {
			input = { default_prompt = "➤ " },
			select = { backend = { "telescope", "builtin" } },
		},
	},

	--  Noice.nvim [better cmd/search line]
	--  https://github.com/folke/noice.nvim
	--  We use it for:
	--  * cmdline: Display treesitter for :
	--  * search: Display a magnifier instead of /
	--
	--  We don't use it for:
	--  * LSP status: We use a heirline component for this.
	--  * Search results: We use a heirline component for this.
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = function()
			local enable_conceal = false -- Hide command text if true
			return {
				presets = { bottom_search = true }, -- The kind of popup used for /
				cmdline = {
					view = "cmdline", -- The kind of popup used for :
					format = {
						cmdline = { conceal = enable_conceal },
						search_down = { conceal = enable_conceal },
						search_up = { conceal = enable_conceal },
						filter = { conceal = enable_conceal },
						lua = { conceal = enable_conceal },
						help = { conceal = enable_conceal },
						input = { conceal = enable_conceal },
					},
				},

				-- Disable every other noice feature
				messages = { enabled = false },
				lsp = {
					hover = { enabled = false },
					signature = { enabled = false },
					progress = { enabled = false },
					message = { enabled = false },
					smart_move = { enabled = false },
				},
			}
		end,
	},

	--  UI icons [icons]
	--  https://github.com/nvim-tree/nvim-web-devicons
	{
		"nvim-tree/nvim-web-devicons",
		enabled = vim.g.icons_enabled,
		opts = {
			override = {
				default_icon = {
					icon = require("core.utils").get_icon("DefaultFile"),
					name = "default",
				},
			},
		},
		config = function(_, opts)
			require("nvim-web-devicons").setup(opts)
			pcall(vim.api.nvim_del_user_command, "NvimWebDeviconsHiTest")
		end,
	},

	--  LSP icons [icons]
	--  https://github.com/onsails/lspkind.nvim
	{
		"onsails/lspkind.nvim",
		opts = {
			menu = {},
			mode = "symbol_text",
			symbol_map = {
				Array = "󰅪",
				Boolean = "⊨",
				Class = "󰌗",
				Constructor = "",
				Key = "󰌆",
				Namespace = "󰅪",
				Null = "NULL",
				Number = "#",
				Object = "󰀚",
				Package = "󰏗",
				Property = "",
				Reference = "",
				Snippet = "",
				String = "󰀬",
				TypeParameter = "󰊄",
				Unit = "",
			},
		},
		enabled = vim.g.icons_enabled,
		config = function(_, opts)
			require("lspkind").init(opts)
		end,
	},

	--  nvim-scrollbar [scrollbar]
	--  https://github.com/petertriho/nvim-scrollbar
	{
		"petertriho/nvim-scrollbar",
		event = "User BaseFile",
		opts = {
			handlers = {
				gitsigns = true, -- gitsigns integration (display hunks)
				ale = true, -- lsp integration (display errors/warnings)
				search = false, -- hlslens integration (display search result)
			},
			excluded_filetypes = {
				"cmp_docs",
				"cmp_menu",
				"noice",
				"prompt",
				"TelescopePrompt",
				"alpha",
			},
		},
	},

	--  mini.animate [animations]
	--  https://github.com/echasnovski/mini.animate
	--  HINT: if one of your personal keymappings fail due to mini.animate, try to
	--        disable it during the keybinding using vim.g.minianimate_disable = true
	{
		"echasnovski/mini.animate",
		-- event = "User BaseFile",
		opts = function()
			-- don't use animate when scrolling with the mouse
			local mouse_scrolled = false
			for _, scroll in ipairs({ "Up", "Down" }) do
				local key = "<ScrollWheel" .. scroll .. ">"
				vim.keymap.set({ "", "i" }, key, function()
					mouse_scrolled = true
					return key
				end, { expr = true })
			end

			local animate = require("mini.animate")
			return {
				open = { enable = false }, -- true causes issues on nvim-spectre
				resize = {
					timing = animate.gen_timing.linear({ duration = 33, unit = "total" }),
				},
				scroll = {
					timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
					subscroll = animate.gen_subscroll.equal({
						predicate = function(total_scroll)
							if mouse_scrolled then
								mouse_scrolled = false
								return false
							end
							return total_scroll > 1
						end,
					}),
				},
				cursor = {
					enable = false, -- We don't want cursor ghosting
					timing = animate.gen_timing.linear({ duration = 26, unit = "total" }),
				},
			}
		end,
	},

	--  highlight-undo
	--  https://github.com/tzachar/highlight-undo.nvim
	--  This plugin only flases on redo.
	--  But we also have a autocmd to flash on yank.
	{
		"tzachar/highlight-undo.nvim",
		event = "VeryLazy",
		opts = {
			hlgroup = "CurSearch",
			duration = 150,
			keymaps = {
				{ "n", "u", "undo", {} }, -- If you remap undo/redo, change this
				{ "n", "<C-r>", "redo", {} },
			},
		},
		config = function(_, opts)
			require("highlight-undo").setup(opts)

			-- Also flash on yank.
			vim.api.nvim_create_autocmd("TextYankPost", {
				desc = "Highlight yanked text",
				pattern = "*",
				callback = function()
					vim.highlight.on_yank()
				end,
			})
		end,
	},

	-- vim-illuminate
	-- https://github.com/RRethy/vim-illuminate
	{
		"RRethy/vim-illuminate",
		config = function()
			local illuminate = require("illuminate")

			vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree", "dashboard" }
			vim.api.nvim_set_keymap(
				"n",
				"<a-n>",
				'<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
				{ noremap = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<a-p>",
				'<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
				{ noremap = true }
			)

			illuminate.configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				delay = 200,
				filetypes_denylist = {
					"dirvish",
					"fugitive",
					"alpha",
					"dashboard",
					"NvimTree",
					"packer",
					"neogitstatus",
					"Trouble",
					"lir",
					"Outline",
					"spectre_panel",
					"toggleterm",
					"DressingSelect",
					"TelescopePrompt",
				},
				filetypes_allowlist = {},
				modes_denylist = {},
				modes_allowlist = {},
				providers_regex_syntax_denylist = {},
				providers_regex_syntax_allowlist = {},
				under_cursor = true,
			})
		end,
	},

	-- todo-comments
	-- https://github.com/folke/todo-comments.nvim
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPost",
		config = true,
	},

	-- vim-kitty
	-- https://github.com/fladson/vim-kitty
	{ "fladson/vim-kitty" },

	--  which-key.nvim [on-screen keybindings]
	--  https://github.com/folke/which-key.nvim
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			icons = { group = vim.g.icons_enabled and "" or "+", separator = "" },
			disable = { filetypes = { "TelescopePrompt" } },
		},
		config = function(_, opts)
			require("which-key").setup(opts)
			require("core.utils").which_key_register()
		end,
	},
}
