-- LSP config
--
--       ## LSP
--       -> nvim-java                      [java support]
--       -> mason-lspconfig                [auto start lsp]
--       -> nvim-lspconfig                 [lsp configs]
--       -> mason.nvim                     [lsp package manager]
--       -> SchemaStore.nvim               [lsp schema manager]
--       -> conform                        [lsp code formatting]
--       -> nvim-lint                      [lsp linting]
--       -> neodev                         [lsp for nvim lua api]
--       -> garbage-day                    [lsp garbage collector]
--       -> lsp-lens                       [lsp enhancement]
--       -> fidget                         [lsp messages]
--
--       ## COMPILER
--       -> compiler.nvim                  [compiler]
--       -> overseer.nvim                  [task runner]
local utils = require("core.utils")
local utils_lsp = require("core.utils.lsp")
return {
	--  LSP -------------------------------------------------------------------

	-- nvim-java [java support]
	-- https://github.com/nvim-java/nvim-java
	-- Reliable jdtls support. Must go before mason-lspconfig nad lsp-config.
	{
		"nvim-java/nvim-java",
		ft = { "java" },
		dependencies = {
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"MunifTanjim/nui.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			{
				"williamboman/mason.nvim",
				opts = {
					registries = {
						"github:nvim-java/mason-registry",
						"github:mason-org/mason-registry",
					},
				},
			},
		},
	},

	--  nvim-lspconfig [lsp configs]
	--  https://github.com/neovim/nvim-lspconfig
	--  This plugin provide default configs for the lsp servers available on mason.
	{
		"neovim/nvim-lspconfig",
		event = "User BaseFile",
	},

	-- mason-lspconfig [auto start lsp]
	-- https://github.com/williamboman/mason-lspconfig.nvim
	-- This plugin auto starts the lsp servers installed by Mason
	-- every time Neovim trigger the event FileType.
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		event = "User BaseFile",
		opts = function(_, opts)
			if not opts.handlers then
				opts.handlers = {}
			end
			opts.handlers[1] = function(server)
				utils_lsp.setup(server)
			end
		end,
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
			utils_lsp.apply_default_lsp_settings() -- Apply our default lsp settings.
			utils.trigger_event("FileType") -- This line starts this plugin.
		end,
	},

	-- mason tool installer [auto installer for mason]
	-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			ensure_installed = {
				"bashls",
				"cssls",
				"delve",
				"eslint_d",
				"gopls",
				"goimports",
				"gofumpt",
				"golangci-lint",
				"gomodifytags",
				"gotests",
				"html-lsp",
				"impl",
				"java-test",
				"java-debug-adapter",
				"jdtls",
				"json-lsp",
				"js-debug-adapter",
				"lua_ls",
				"marksman",
				"node-debug2-adapter",
				"prettierd",
				"stylua",
				"tsserver",
				"tailwindcss-language-server",
				"vimls",
			},
			auto_update = true,
			run_on_start = true,
			start_delay = 3000, -- 3 second delay
			debounce_hours = 5, -- at least 5 hours between attempts to install/update
		},
	},

	--  mason [lsp package manager]
	--  https://github.com/williamboman/mason.nvim
	--  https://github.com/Zeioth/mason-extra-cmds
	{
		"williamboman/mason.nvim",
		dependencies = { "Zeioth/mason-extra-cmds", opts = {} },
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
			"MasonUpdate",
			"MasonUpdateAll", -- this cmd is provided by mason-extra-cmds
		},
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_uninstalled = "✗",
					package_pending = "⟳",
				},
			},
		},
	},

	--  Schema Store [lsp schema manager]
	--  https://github.com/b0o/SchemaStore.nvim
	"b0o/SchemaStore.nvim",

	-- conform [formatter]
	-- https://github.com/stevearc/conform.nvim
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { { "prettierd", "prettier" } },
					typescript = { { "prettierd", "prettier" } },
					javascriptreact = { { "prettierd", "prettier" } },
					typescriptreact = { { "prettierd", "prettier" } },
					svelte = { { "prettierd", "prettier" } },
					css = { { "prettierd", "prettier" } },
					html = { { "prettierd", "prettier" } },
					json = { { "prettierd", "prettier" } },
					yaml = { { "prettierd", "prettier" } },
					markdown = { { "prettierd", "prettier" } },
					graphql = { { "prettierd", "prettier" } },
					go = { "goimports", "gofumpt" },
				},
				format_on_save = {
					async = true,
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},

	-- nvim-lint [linter]
	-- https://github.com/mfussenegger/nvim-lint
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				go = { "golangcilint" },
				javascript = { { "eslint_d", "eslint" } },
				typescript = { { "eslint_d", "eslint" } },
				javascriptreact = { { "eslint_d", "eslint" } },
				typescriptreact = { { "eslint_d", "eslint" } },
				svelte = { { "eslint_d", "eslint" } },
			}

			vim.keymap.set("n", "<leader>lx", function()
				lint.try_lint()
			end, { desc = "Run linter" })
		end,
	},

	--  neodev.nvim [lsp for nvim lua api]
	--  https://github.com/folke/neodev.nvim
	{
		"folke/neodev.nvim",
		ft = { "lua" },
		opts = {},
	},

	--  garbage-day.nvim [lsp garbage collector]
	--  https://github.com/zeioth/garbage-day.nvim
	{
		"zeioth/garbage-day.nvim",
		event = "User BaseFile",
		opts = {
			aggressive_mode = false,
			excluded_lsp_clients = {
				"null-ls",
				"jdtls",
			},
			grace_period = (60 * 15),
			wakeup_delay = 3000,
			notifications = false,
			retries = 3,
			timeout = 1000,
		},
	},

	-- aerial
	{
		"stevearc/aerial.nvim",
		opts = {
			attach_mode = "global",
			backends = { "lsp", "treesitter", "markdown", "man" },
			layout = { min_width = 28 },
			show_guides = true,
			filter_kind = false,
			guides = {
				mid_item = "├ ",
				last_item = "└ ",
				nested_top = "│ ",
				whitespace = "  ",
			},
			keymaps = {
				["[y"] = "actions.prev",
				["]y"] = "actions.next",
				["[Y"] = "actions.prev_up",
				["]Y"] = "actions.next_up",
				["{"] = false,
				["}"] = false,
				["[["] = false,
				["]]"] = false,
			},
		},
	},

	-- fidget
	-- https://github.com/j-hui/fidget.nvim
	{
		"j-hui/fidget.nvim",
		config = true,
		tag = "legacy",
	},

	-- lsp lens [lsp info]
	-- https://github.com/VidocqH/lsp-lens.nvim
	{
		"VidocqH/lsp-lens.nvim",
		config = true,
	},

	--  COMPILER ----------------------------------------------------------------
	--  compiler.nvim [compiler]
	--  https://github.com/Zeioth/compiler.nvim
	{
		"Zeioth/compiler.nvim",
		cmd = {
			"CompilerOpen",
			"CompilerToggleResults",
			"CompilerRedo",
			"CompilerStop",
		},
		dependencies = { "stevearc/overseer.nvim" },
		opts = {},
	},

	--  overseer [task runner]
	--  https://github.com/stevearc/overseer.nvim
	{
		"stevearc/overseer.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults" },
		opts = {
			-- Tasks are disposed 5 minutes after running to free resources.
			-- If you need to close a task immediately:
			-- press ENTER in the output menu on the task you wanna close.
			task_list = { -- this refers to the window that shows the result
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1,
			},
			-- component_aliases = { -- uncomment this to disable notifications
			--   -- Components included in default will apply to all tasks
			--   default = {
			--     { "display_duration", detail_level = 2 },
			--     "on_output_summarize",
			--     "on_exit_set_status",
			--     --"on_complete_notify",
			--     "on_complete_dispose",
			--   },
			-- },
		},
	},
}
