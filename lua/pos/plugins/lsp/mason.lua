return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
					border = "double",
					width = 0.8,
					height = 0.8,
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local wk = require("which-key")
			local capabilities = cmp_nvim_lsp.default_capabilities()

			local register_keys = function(keys)
				local opts = {
					mode = "n", -- NORMAL mode
					prefix = "<leader>",
					buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
					silent = true, -- use `silent` when creating keymaps
					noremap = true, -- use `noremap` when creating keymaps
					nowait = true, -- use `nowait` when creating keymaps
				}
				wk.register(keys, opts)
			end
			require("mason-lspconfig").setup({
				-- auto installation
				automatic_installation = true,
			})
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				--- go lsp
				["gopls"] = function()
					lspconfig.gopls.setup({
						capabilities = capabilities,
						on_attach = function(client, _)
							if client.name == "gopls" then
								if not client.server_capabilities.semanticTokensProvider then
									local semantic = client.config.capabilities.textDocument.semanticTokens
									client.server_capabilities.semanticTokensProvider = {
										full = true,
										legend = {
											tokenTypes = semantic.tokenTypes,
											tokenModifiers = semantic.tokenModifiers,
										},
										range = true,
									}
								end

								register_keys({
									c = {
										name = "Go",
										i = { "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies" },
										f = { "<cmd>GoMod tidy<cr>", "Tidy" },
										a = { "<cmd>GoTestAdd<Cr>", "Add Test" },
										A = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
										e = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
										g = { "<cmd>GoGenerate<Cr>", "Go Generate" },
										G = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
										c = { "<cmd>GoCmt<Cr>", "Generate Comment" },
										t = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test" },
									},
								})
							end
						end,
						settings = {
							gopls = {
								gofumpt = true,
								codelenses = {
									gc_details = false,
									generate = true,
									regenerate_cgo = true,
									run_govulncheck = true,
									test = true,
									tidy = true,
									upgrade_dependency = true,
									vendor = true,
								},
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									compositeLiteralTypes = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
								analyses = {
									fieldalignment = true,
									nilness = true,
									unusedparams = true,
									unusedwrite = true,
									useany = true,
								},
								usePlaceholders = true,
								completeUnimported = true,
								staticcheck = true,
								directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
								semanticTokens = true,
							},
						},
					})
				end,

				-- typescript / javascript
				["tsserver"] = function()
					lspconfig.tsserver.setup({
						capabilities = capabilities,
						on_attach = function()
							register_keys({
								c = {
									name = "Typescript",
									o = {
										function()
											vim.lsp.buf.code_action({
												apply = true,
												context = {
													only = { "source.organizeImports.ts" },
													diagnostics = {},
												},
											})
										end,
										"Organize Imports",
									},
									r = {
										function()
											vim.lsp.buf.code_action({
												apply = true,
												context = {
													only = { "source.removeUnused.ts" },
													diagnostics = {},
												},
											})
										end,
										"Remove Unused Imports",
									},
								},
							})
						end,
						settings = {
							typescript = {
								format = {
									indentSize = vim.o.shiftwidth,
									convertTabsToSpaces = vim.o.expandtab,
									tabSize = vim.o.tabstop,
								},
							},
							javascript = {
								format = {
									indentSize = vim.o.shiftwidth,
									convertTabsToSpaces = vim.o.expandtab,
									tabSize = vim.o.tabstop,
								},
							},
							completions = {
								completeFunctionCalls = true,
							},
						},
					})
				end,

				-- lua lsp
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
								runtime = {
									version = "LuaJIT",
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
									},
								},
							},
						},
					})
				end,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- you can turn off/on auto_update per tool
					{ "bashls" },
					{ "cssls" },
					{ "delve" },
					{ "eslint_d" },
					{ "eslint-lsp" },
					{ "gopls" },
					{ "html-lsp" },
					{ "json-lsp" },
					{ "js-debug-adapter" },
					{ "lua_ls" },
					{ "marksman" },
					{ "node-debug2-adapter" },
					{ "prettier" },
					{ "stylua" },
					{ "tsserver" },
					{ "tailwindcss-language-server" },
					{ "vimls" },
				},

				auto_update = true,
				run_on_start = true,
				start_delay = 3000, -- 3 second delay
				debounce_hours = 5, -- at least 5 hours between attempts to install/update
			})
		end,
	},
}
